import 'package:fac/home/Userbottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAI extends StatefulWidget {
  const GeminiAI({super.key});

  @override
  State<GeminiAI> createState() => _GeminiAIState();
}

class _GeminiAIState extends State<GeminiAI> {
  var loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
          leading: Navigator.canPop(context)?InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new,color: Colors.white,)):Text(""),
          title: Text(
            "Chat With AI",
            style: TextStyle(
                color: Colors.white
            ),
          )
      ),
      body: ChatScreen(),
      bottomNavigationBar: Userbottom(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final TextEditingController _textEditingController=TextEditingController();
  final ScrollController _scrol= ScrollController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    _model = GenerativeModel(model: "gemini-pro", apiKey: dotenv.env["API_KEY_GOOLE"]!);
    _chat = _model.startChat();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool hasApiKey = dotenv.env["API_KEY_GOOLE"] != null && dotenv.env["API_KEY_GOOLE"]!.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: hasApiKey?ListView.builder(itemBuilder: (context,idx){
            final content = _chat.history.toList()[idx];
            final text = content.parts.whereType<TextPart>().map<String>((e) => e.text).join('');
            return MessageWidgt(
              text:text,
              isFromUser:content.role == 'user',
            );
          },
            itemCount: _chat.history.length,
          ):ListView(
            children: [
              Text("No API key found . Please provide an API key."),
            ],
          )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 4
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Enter a prompt...',
                    border:  OutlineInputBorder(
                      borderRadius:BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Colors.black
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                  ),
                  onFieldSubmitted: (String value){
                    if(_textEditingController.text.isNotEmpty) {
                      _sendChatMessage(value);
                    }
                  },
                )
                ),
                SizedBox.square(
                  dimension: 10,
                ),
                if(!loading)
                  IconButton(onPressed: (){
                    if(_textEditingController.text.isNotEmpty) {
                      _sendChatMessage(_textEditingController.text);
                    }
                  }, icon: Icon(
                      Icons.send,
                    color: Color(0xFF118743),
                  ))
                else
                   CircularProgressIndicator(),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<void> _sendChatMessage(String message)async{
    setState(() {
      loading = true;
    });
    try{
      final response = await _chat.sendMessage(Content.text(message));
      final text = response.text;
      if(text == null){
        debugPrint('NO Response from api');
        return;
      }
      setState(() {
        loading = false;
      });
    }catch(e){
      debugPrint(e.toString());
    }finally{
      _textEditingController.clear();
      setState(() {
        loading=false;
      });
  }
  }
}

class MessageWidgt extends StatelessWidget {
  final String text;
  final bool isFromUser;
  const MessageWidgt({
    super.key,
    required this.text,
    required this.isFromUser
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFromUser?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: isFromUser?Colors.grey:const Color.fromRGBO(0, 166, 126, 1),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            margin: EdgeInsets.only(bottom: 8),
            child: MarkdownBody(
              selectable: true,
              data: text,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(color: Colors.white), // Paragraph text style
                h1: TextStyle(color: Colors.white), // Header 1 text style
                h2: TextStyle(color: Colors.white), // Header 2 text style
                h3: TextStyle(color: Colors.white), // Header 3 text style
                h4: TextStyle(color: Colors.white), // Header 4 text style
                h5: TextStyle(color: Colors.white), // Header 5 text style
                h6: TextStyle(color: Colors.white), // Header 6 text style// Italic text style
                code: TextStyle(color: Colors.black), // Code text style
                // Blockquote text style
                // Add more style customizations as needed
              ),
            ),
          ),
        )
      ],
    );
  }
}


