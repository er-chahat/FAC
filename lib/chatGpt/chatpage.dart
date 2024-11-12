import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:fac/chatGpt/consts.dart';
import 'package:flutter/material.dart';

class ChatAI extends StatefulWidget {
  const ChatAI({super.key});

  @override
  State<ChatAI> createState() => _ChatAIState();
}

class _ChatAIState extends State<ChatAI> {
  final _openAi = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5,)),
    enableLog: true
  );

  final ChatUser _currentUser = ChatUser(id: "1",firstName: "Mehak",lastName: "Thakur");
  final ChatUser _gptChatUser = ChatUser(id: "2",firstName: "Chat",lastName: "gpt");
  List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    // TODO: implement initState
    print("hello you api key ${OPENAI_API_KEY}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
        title: Text(
          "Chat With AI",
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: DashChat(currentUser: _currentUser,
          messageOptions: const MessageOptions(
            currentUserContainerColor: Colors.black,
            containerColor: const Color.fromRGBO(0, 166, 126, 1),
            textColor: Colors.white
          ),
          onSend: (ChatMessage m){
        getChatResponse(m);
      }, messages: _messages),
    );
  }
  Future<void> getChatResponse(ChatMessage m)async{
    print("meshshae ${m.text}");
    setState(() {
      _messages.insert(0, m);
    });
    List<Map<String, dynamic>> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return {
          'role': "user",
          'content': m.text,
        };
      } else {
        return {
          'role': "assistant",
          'content': m.text,
        };
      }
    }).toList();
    print("roles  are ${Role.user},${Role.assistant}");
    final request = ChatCompleteText(model: GptTurbo0301ChatModel(), messages: _messagesHistory,maxToken: 200);
    print("hello its your chat gpt $request");
    try {
      final response = await _openAi.onChatCompletion(request: request);
      print("hello its your chat gpt  $response");
      print("hello its your chat gpt ${response!.choices}");
      for (var element in response!.choices) {
        setState(() {
          _messages.insert(0, ChatMessage(user: _gptChatUser,
              createdAt: DateTime.now(),
              text: element.message!.content));
        });
      }
    }catch (e) {
      print("Error:exception $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Quota Exceeded"),
          content: Text("You have exceeded your API quota. Please check your plan and billing details."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
