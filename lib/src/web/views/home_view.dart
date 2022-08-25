import 'package:cies_web_socket/global/environment.dart';
import 'package:cies_web_socket/src/web/models/message_chat_model.dart';
import 'package:cies_web_socket/src/web/provider/auth_provider.dart';
import 'package:cies_web_socket/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'widgets/chat_message_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final scrollController = ScrollController();

  final _message = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessageWidget> _messages = [];
  bool _estaEscribiendo = false;

  String userId = "1";
  String channelId = "1";

  bool initialData = true;

  bool loading = false;
  late IO.Socket socket;

  String actualChannel = "";
  @override
  void initState() {
    super.initState();
    _initSocket();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  final List<dynamic> _channels = [];

  _initSocket() {
    socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
    });
    socket.on('connect', (_) async {
      dynamic data = {
        "id": userId,
        "name": "Atención",
        "channel_id": channelId,
      };
      socket.emit('user_connected', data);
      socket.emit('login_admin', data);

      socket.emit("get_admin_channels", channelId);

      socket.on('get_admin_channels', (data) {
        _channels.clear();
        for (var item in data) {
          _channels.add(item);
        }
        setState(() {});
      });

      socket.on('get_actual_chats', (data) {
        loading = true;
        List<MessageChatModel> sms = [];
        _messages.clear();
        for (var item in data) {
          sms.add(MessageChatModel.fromJson(item));
        }
        final history = sms
            .map(
              (obj) => ChatMessageWidget(
                username: '',
                user: userId,
                uid: obj.userSocketId,
                texto: obj.message,
                animationController: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 0))
                  ..forward(),
              ),
            )
            .toList();
        _messages.insertAll(0, history);
        initialData = false;
        loading = false;
        setState(() {});
      });
    });
  }

  _getActualChannelChats() {
    socket.off("get_message_$actualChannel");
    socket.emit("get_actual_chats", actualChannel);
    socket.on('get_message_$actualChannel', (data) {
      MessageChatModel obj = MessageChatModel.fromJson(data);
      final history = ChatMessageWidget(
        username: "",
        user: userId,
        uid: obj.userSocketId,
        texto: obj.message,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 200))
          ..forward(),
      );
      setState(() {
        _messages.insert(0, history);
      });
    });
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              // Input text
              Flexible(
                child: TextField(
                  controller: _message,
                  onSubmitted: _handleSubmit,
                  onChanged: (texto) {
                    setState(() {
                      if (texto.trim().isNotEmpty) {
                        _estaEscribiendo = true;
                      } else {
                        _estaEscribiendo = false;
                      }
                    });
                  },
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Enviar mensaje'),
                  focusNode: _focusNode,
                ),
              ),
              // Send button
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: const IconThemeData(color: Color(0xFF23a950)),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.send),
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_message.text.trim())
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    setState(() {
      initialData = false;
    });
    if (texto.isEmpty) return;

    _message.clear();
    _focusNode.requestFocus();

    dynamic sms = {
      "user_id": userId,
      "channel_id": actualChannel,
      "message": texto,
      "type": "1",
    };

    socket.emit('create_message', sms);

    // setState(() {
    //   _messages.insert(0, newMessage);
    //   newMessage.animationController.forward();
    // });

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cies Chat"),
        centerTitle: true,
        backgroundColor: const Color(0xFF23a950),
        actions: [
          IconButton(
            onPressed: () {
              socket.disconnect();
              socket.dispose();
              authProvider.deleteCredencial();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: size.height,
            child: SizedBox(
              width: size.width * 0.2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _channels.isEmpty
                      ? [
                          const Center(
                            child:
                                CustomText("No existen contactos disponibles"),
                          )
                        ]
                      : _channels
                          .map<Widget>(
                            (e) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: InkWell(
                                onTap: () {
                                  actualChannel =
                                      "${channelId}_${e['channel']}";
                                  setState(() {});
                                  _getActualChannelChats();
                                },
                                child: Card(
                                    color: actualChannel ==
                                            "${channelId}_${e["channel"]}"
                                        ? Colors.orange
                                        : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Icon(
                                            Icons.account_circle,
                                            color: actualChannel ==
                                                    "${channelId}_${e["channel"]}"
                                                ? Colors.white
                                                : const Color(0xFF23a950),
                                          ),
                                          const SizedBox(width: 10),
                                          CustomText(
                                            e["name"],
                                            color: actualChannel ==
                                                    "${channelId}_${e["channel"]}"
                                                ? Colors.white
                                                : const Color(0xFF23a950),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.chat,
                                                color: actualChannel ==
                                                        "${channelId}_${e["channel"]}"
                                                    ? Colors.white
                                                    : const Color(0xFF23a950),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: const [],
                        ),
                      ),
                      initialData
                          ? Container(
                              padding: const EdgeInsets.only(top: 20),
                              width: double.maxFinite,
                              child: const CustomText(
                                'Inicio de la conversación',
                                color: Color(0xFF23a950),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox(),
                      initialData
                          ? Container(
                              padding:
                                  const EdgeInsets.only(left: 70, right: 70),
                              width: double.maxFinite,
                              child: const CustomText(
                                'Contactando con un agente de información...',
                                color: Color(0xFFb6b6b6),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox(),
                      initialData
                          ? Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.only(top: 70),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/speech-bubble.svg',
                                width: 100,
                                color: const Color(0xffF58220),
                              ),
                            )
                          : const SizedBox(),
                      Flexible(
                        child: ListView.builder(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _messages.length,
                          itemBuilder: (_, i) => _messages[i],
                          reverse: true,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: _inputChat(),
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
