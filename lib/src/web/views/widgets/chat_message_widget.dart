import 'package:bubble/bubble.dart';
import 'package:cies_web_socket/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageWidget extends StatelessWidget {
  final String texto;
  final String user;
  final String username;
  final String uid;
  final AnimationController animationController;
  final String? attachment;
  final int? typeAttachment;
  final DateTime? date;

  const ChatMessageWidget({
    required this.username,
    required this.user,
    required this.texto,
    required this.uid,
    required this.animationController,
    this.attachment,
    this.typeAttachment,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat ft = DateFormat('HH:MM');
    DateFormat fy = DateFormat('dd-MM-yyyy');

    DateTime lastDate = (date ?? DateTime.now());

    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime yesterday1 = DateTime(now.year, now.month, now.day - 2);
    String lastConnection = '';
    if (lastDate.isBefore(now) && lastDate.isAfter(yesterday)) {
      String date = ft.format(lastDate);
      lastConnection = date;
    } else {
      if (lastDate.isBefore(yesterday) && lastDate.isAfter(yesterday1)) {
        String date = ft.format(lastDate);
        lastConnection = date;
      } else {
        String date = fy.format(lastDate);
        lastConnection = date;
      }
    }

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == user
              ? (attachment == null
                  ? _myMessage(lastConnection)
                  : _myFileMessage(lastConnection))
              : (attachment == null
                  ? _notMyMessage(lastConnection)
                  : _notMyFileMessage(lastConnection)),
        ),
      ),
    );
  }

  Widget _myFileMessage(lastConnection) {
    // 1 image
    if (typeAttachment == 1) {
      return Bubble(
        color: const Color(0xFF23a950),
        margin: const BubbleEdges.only(top: 5, bottom: 5, right: 3, left: 70),
        alignment: Alignment.topRight,
        nip: BubbleNip.rightTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              child: SizedBox(
                height: 200,
                child: Image.network(attachment!),
              ),
              onTap: () {},
            ),
          ],
        ),
      );
    }
    // 2 pdf
    if (typeAttachment == 2) {
      return InkWell(
        onTap: () {},
        child: Bubble(
          color: const Color(0xFF23a950),
          margin: const BubbleEdges.only(top: 5, bottom: 5, right: 3, left: 70),
          alignment: Alignment.topRight,
          nip: BubbleNip.rightTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CustomText(
                'Archivo PDF',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              CustomText(
                attachment!,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Widget _notMyFileMessage(lastConnection) {
    // 1 image
    if (typeAttachment == 1) {
      return Bubble(
        color: Colors.white,
        margin: const BubbleEdges.only(top: 5, bottom: 5, left: 3, right: 70),
        alignment: Alignment.topLeft,
        nip: BubbleNip.leftTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(username,
                color: const Color(0xFF23a950),
                fontSize: 12,
                fontWeight: FontWeight.w400),
            InkWell(
              child: SizedBox(
                height: 200,
                child: Image.network(attachment!),
              ),
              onTap: () {},
            ),
          ],
        ),
      );
    }
    // 2 pdf
    if (typeAttachment == 2) {
      return InkWell(
        onTap: () {},
        child: Bubble(
          color: Colors.white,
          margin: const BubbleEdges.only(top: 5, bottom: 5, left: 3, right: 70),
          alignment: Alignment.topLeft,
          nip: BubbleNip.leftTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(username,
                  color: const Color(0xFF23a950),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              const SizedBox(
                width: double.maxFinite,
                child: CustomText(
                  'Archivo PDF',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF23a950),
                  textAlign: TextAlign.end,
                ),
              ),
              CustomText(attachment!,
                  fontWeight: FontWeight.w400, color: const Color(0xFF23a950)),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Widget _myMessage(lastConnection) {
    return Bubble(
      color: const Color(0xFF23a950),
      margin: const BubbleEdges.only(top: 5, bottom: 5, right: 3, left: 70),
      alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomText(
            texto,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          CustomText(
            lastConnection,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  Widget _notMyMessage(lastConnection) {
    return Bubble(
        color: Colors.white,
        margin: const BubbleEdges.only(top: 5, bottom: 5, left: 3, right: 70),
        alignment: Alignment.topLeft,
        nip: BubbleNip.leftTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomText(
            //   username.isEmpty ? 'User 2' : username,
            //   color: const Color(0xFF23a950).withOpacity(0.7),
            //   fontSize: 12,
            //   fontWeight: FontWeight.w600,
            // ),
            CustomText(
              texto,
              color: const Color(0xFF23a950),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            CustomText(
              lastConnection,
              color: const Color(0xFF23a950).withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ],
        ));
  }
}
