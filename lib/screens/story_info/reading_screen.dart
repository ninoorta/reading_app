import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:reading_app/screens/story_info/menu_chapters_screen.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({Key? key}) : super(key: key);

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  bool visible = false;

  String testHTML =
      '\"Sư phụ! —— sư phụ đừng đuổi chúng con đi mà —— \"<br><br>Thanh âm vang lên vô cùng thê thảm bi thương, nhưng vẫn không ngăn được cánh cửa lớn trước mặt lưu loát đóng lại, phát ra một tiếng \"Phang\" lạnh lùng.<br><br>Một nữ tử trong bộ xiêm y màu xanh, thân hình đơn bạc ghé chặt vào trên cánh cửa đại môn bằng gỗ, hai tay không ngừng đập cửa, tiếng thổn thức thê lương mong mỏi người ở bên trong có thể mở cửa cho bọn họ đi vào. Nhưng mà dù nàng có kêu đến mấy đi nữa, người bên trong cũng không mềm lòng, đại môn từ đầu đến cuối đều không mở ra, xem ra đã quyết tâm muốn đuổi bọn họ ra khỏi cửa.<br><br>Mễ Vị than thở khóc lóc, kêu nửa ngày cũng không làm cho cánh cửa đại môn mở ra, rốt cuộc cũng chết tâm, chậm rãi đứng thẳng người lên, lau lau khuôn mặt không có bao nhiêu nước mắt, lại phủi phủi bàn tay nãy giờ đã đập cửa có chút run run, quay đầu nhìn người bên cạnh bất đắc dĩ nói: \"Tiểu Đầu Trọc, xem ra trụ trì lần này thật sự muốn đuổi hai chúng ta ra khỏi cửa rồi.\" Hai mẹ con rốt cuộc không còn cách nào ở trong này sống kiếp cá mặn ăn nhờ ở đậu nữa.<br><br>Đứng bên cạnh Mễ Vị là một đứa bé trai chỉ cao đến đùi nàng, mặc một bộ tăng phục màu xanh, đỉnh đầu láng bóng, trên cổ còn mang một chuỗi tràng hạt, nhìn qua mười phần là một chú tiểu nhỏ xíu tròn ủm.<br><br>Chú tiểu nhỏ tên là Tiểu Đầu Trọc theo bản năng sờ sờ cái đầu trơn bóng của mình, chớp chớp đôi mắt đen to lúng liếng một chút, một bàn tay cầm lấy túi hành lý đặt trên mặt đất, một tay còn lại giữ chặt tay nữ tử bên cạnh, vừa mở miệng, giọng nói trẻ con non nớt đáng yêu vang lên, \"Nương, đừng gọi nữa, sư phụ đâu có đuổi hai chúng ta ra khỏi cửa, người chỉ muốn chúng ta xuống núi một chuyến, đi thôi nà.\"<br><br>Đôi mắt Mễ Vị hơi thương xót nhìn thằng nhóc con mũm mĩm cái gì cũng không biết bên cạnh, lại quay đầu nhìn cánh cửa miếu đóng chặt, thở dài một hơi cho kiếp cá mặn một đi không trở lại của mình, cuối cùng nhận mệnh nhấc hàng lý lên trên vai, nắm lấy tay của oắt con đi xuống núi.<br><br>Hai mẫu tử men theo đường núi từ từ đi xuống, mắt lại nhìn về nơi mà mình đã sống bốn năm qua. Lúc trước, nàng tỉnh lại trên ngọn núi này, vừa mở mắt ra liền phát hiện mình đang an lành ở thế kỷ 21 đột nhiên xuyên đến một nơi không rõ thời đại này, nhập vào trên người một cô gái không rõ thân phận, hơn nữa trong đầu lại không có một chút ký ức nào về nguyên chủ khi còn sống, quả thực là âm u mù mịt, ngơ ngác đến không được. Càng làm cho nàng thêm chấn động chính là trong bụng của nàng thế nhưng còn mang thai, lần xuyên không này không chỉ thay đổi thời không mà còn thay đổi luôn cả thân phận, ngay cả con cũng có luôn.<br><br>May mắn trời không tuyệt đường người, trụ trì của ngôi miếu nhỏ này phát hiện ra nàng, sau khi tìm hiểu đến tình huống của nàng, chứa chấp mẹ con hai người, cho hai mẹ con có chỗ dung thân. Một lần cưu mang này liền kéo dài bốn năm, trong bốn năm này nàng đã trải qua rất nhẹ nhàng, không còn cảnh cả ngày bận rộn, không còn cảnh vất vả suy nghĩ chỉ dạy, còn có một thằng oắt con vô cùng đáng yêu, cuộc sống vô cùng khoái hoạt, cũng xem như thỏa mãn nguyện vọng trước khi chết của nàng ở kiếp trước: Sống cuộc đời ăn nằm như một con cá mặn, nghỉ ngơi thật tốt.<br><br>Đáng tiếc cuộc vui chóng tàn, sinh nhật ba tuổi của thằng oắt con mới qua không bao lâu, trụ trì liền đóng gói hai mẹ con ném ra khỏi miếu, bảo bọn họ xuống núi tự sinh tự diệt.<br><br>Đi đại khái một canh giờ, hai mẫu tử cuối cùng đã tới thị trấn dưới chân núi. Cái thị trấn này là một trấn lớn, kinh tế rất là phồn hoa, trên đường cái người đến người đi, tiếng người bán hàng rong rao hàng nối tiếp nhau không dứt, cảnh tượng vô cùng náo nhiệt.<br><br>Mễ Tiểu Bảo từ sau khi sinh ra đều ở suốt trong miếu, hoàn toàn chưa từng xuống núi, trong cuộc đời hơn ba năm của đứa nhỏ này, đây là lần đầu tiên nhìn thấy nhiều người như vậy, đường cái náo nhiệt trong nháy mắt liền hấp dẫn ánh mắt của nó, khiến nó trong lúc nhất thời đều không thể dứt mắt ra được, trong ánh mắt tràn đầy tò mò.<br><br>Mễ Vị tuy cũng rất ít xuống núi, nhưng so với Mễ Tiểu Bảo cái đồ nhà quê chưa trải việc đời vẫn khá hơn nhiều, tối thiểu giờ phút này nàng cũng không có tâm trạng chú ý này phố xá náo nhiệt, giờ phút này nàng quan tâm nhất là một vấn đề lớn —— tiền.<br><br>Bốn năm này hai mẫu tử các nàng đều sinh hoạt bên trong miếu, nàng dựa vào việc làm cơm chay cho các tăng nhân trong chùa để đổi lấy sinh hoạt phí cho hai mẹ con, tuy rằng ăn uống không lo, nhưng trong tay cũng không có bao nhiêu tiền, giờ phút này trong túi nàng cũng chỉ có chưa đến mười đồng tiền, ngay cả trọ qua một đêm trong khách điếm cũng không đủ.<br><br>Không nghĩ đến sau khi nàng cá mặn bốn năm, cuối cùng vẫn phát sầu vì tiền.<br><br>Vào thời khắc này, nàng nghe được một tràn âm thanh ùng ục ục, cắt ngang ưu sầu của nàng.<br><br>Mễ Tiểu Bảo lập tức đưa tay che lấy cái bụng nhỏ của mình, ngước đầu nhìn Mễ Vị.<br><br>Mễ Vị ngồi xổm xuống, xoa xoa cái bụng nhỏ mũm mĩm của nó, \"Tiểu Đầu Trọc, con đói bụng rồi?\"<br><br>Mễ Tiểu Bảo gật đầu, ánh mắt không tự chủ liếc sang sạp đồ ăn ở ven đường.<br><br>Mễ Vị sờ sờ tiền trong túi, nắm tay nó đi đến một sạp bán mì ven đường, tìm một cái bàn không ngồi xuống, cất giọng nhìn chủ quán nói: \"Chủ quán, cho hai bát mì!\"<br><br>Chủ quán nhìn Mễ Vị,một nữ tử trẻ gầy teo yếu ớt mang theo một hài tử đến ăn mì, không khỏi nhắc nhở: \"Vị tiểu tẩu tử này, mì quán chúng ta rất nhiều, ngươi và một đứa trẻ chỉ sợ ăn một chén cũng không hết, nhất định gọi hai chén sao?\"<br><br>Mễ Vị tự tin cười một tiếng, \"Hai chén đi, có thể ăn hết!\" Làm gì có chuyện ăn không hết, chỉ sợ còn ăn không đủ no.<br><br>\"Được rồi!\" Chủ quán không nói thêm, đáp lời một tiếng, động tác nhanh nhẹn, chưa được bao lâu đã bưng ra hai chén mì lớn.<br><br>Mễ Vị không khỏi cảm khái, người chủ quán này cũng thật sự không nói điêu, chén mì lớn chừng gấp đôi mặt của nàng, bên trong nêm đầy mì đến chật cứng, một chén này ngay cả một tráng hán trưởng thành cũng có thể ăn no.<br><br>Lấy đôi đũa, dùng khăn lau lau một chút rồi đưa cho oắt con bên cạnh, \"Ăn đi.\"<br><br>Đôi mắt trong suốt của Mễ Tiểu Bảo sáng ngời, hai cái chân ngắn vì cao hứng nhịn không được cứ lúc lắc, nhưng hai bàn tay nhỏ xíu múp múp cầm đôi đũa lại hết sức vững vàng, vùi đầu chăm chú ăn, động tác rất nhanh, nhưng một chút âm thanh cũng không phát ra.<br><br>Mễ Vị thấy nó ăn ngon lành, lại tìm chủ quán mượn thêm một cái chén nhỏ, múc chút mì trong chén to kia ra rồi mới bắt đầu ăn, phần mì còn lại tương đối nhiều vẫn để nguyên trong chén to, đặt bên cạnh không động đến.<br><br>Nàng ăn xong chén mì nhỏ của mình cơ bản đã no rồi, khi ngẩng đầu nhìn lên, Mễ Tiểu Bảo bên cạnh đã ăn xong cái chén mì lớn kia, đang ngoan ngoãn chờ nàng ăn.<br><br>Mễ Vị đem chén mì lớn còn lại bên cạnh đẩy đến trước mặt nó, \"Ăn đi.\"<br><br>Mễ Tiểu Bảo lắc lắc đầu, \"Nương, con không ăn, người ăn đi.\" Nương mới ăn có một chút như vậy thôi mà.<br><br>Mễ Vị vỗ vỗ bụng mình, \"Bụng nương nhỏ, nương ăn bao nhiêu đó đã no rồi, còn dư ăn không hết, con ăn đi.\"<br><br>Mễ Tiểu Bảo nửa tin nửa ngờ nhìn nhìn bụng của nàng, không thể tin được, nương ăn mới chút xíu như thế đã no rồi sao, nó ăn một chén lớn vậy mà cũng còn chưa no đâu.<br><br>\"Con nhìn bụng nương nè, bụng nương bẹp bẹp, còn con nhìn bụng con đi, bụng con phồng phồng, điều này chứng tỏ bụng của con khá lớn cho nên mới có thể chứa được nhiều. Nương ăn một chút là đã lấp đầy bụng rồi.\"<br><br>Thằng nhóc nhỏ cúi đầu nhìn nhìn cái bụng tròn trịa của bản thân, rốt cuộc cũng tin. Đúng rồi, bụng nương quá nhỏ, cho nên không thể chứa nhiều đồ ăn.<br><br>Xác định nương thật sự no rồi, nó sung sướng bưng chén mì lớn kia qua bên chỗ mình, cúi đầu tiếp tục đắc ý ăn.<br><br>Mễ Vị nhìn liền biết nó vẫn chưa ăn no, đối với sức ăn của thằng oắt con nhà mình, nàng là từ cảm xúc khiếp sợ ban đầu cho đến bây giờ đã hoàn toàn chết lặng, để chấp nhận chuyện này cũng trải qua không ít gian khổ. Nhớ ngày đó, sữa nàng cũng tính không ít, nhưng không đủ cho thằng oắt con này ăn, mỗi ngày oắt con đói khóc oa oa, khóc đến nỗi nàng phải mỗi ngày đi xung quanh núi tìm sữa dê cho nó ăn dặm, lúc này mới vừa có thể cho nó no bụng.<br><br>Nhưng theo thời gian, oắt con dần dần lớn lên, sức ăn càng ngày càng đột nhiên tăng mạnh, trong miếu thiếu chút nữa cho nó ăn mà muốn phá sản. Cũng nhờ trù nghệ của nàng tốt, làm cơm chay ngon nên rất nhiều kẻ có tiền ở cạnh cũng thường xuyên chạy đến đây ăn cơm chay, nhờ đó tăng được thêm chút thu nhập cho miếu, nếu không phỏng chừng hai mẹ con bọn sớm đã bị trụ trì đuổi ra khỏi miếu rồi.<br><br>Vì nuôi oắt con này, nàng cũng sống thật không dễ dàng a.<br><br>Lúc mới ban đầu, nàng cũng lo lắng qua có phải thân thể mình bị nạn, xảy ra vấn đề gì cho nên khẩu vị của thằng bé mới lạ lùng như vậy, nhưng sau khi nhờ phó trụ trì y thuật tinh thông xem qua mấy lần, hắn nói thằng bé không phải có bệnh gì, có thể là do trời sinh, lúc đó nàng mới yên lòng lại.<br><br>Suy nghĩ mới vẩn vơ một chút, oắt con đã giải quyết xong chén mì còn lại.<br><br>Mễ Vị sờ sờ bụng của nó, biết nó vẫn chưa ăn no, nhưng chẳng còn cách nào khác; trong túi chỉ có tám đồng tiền, ba văn tiền một chén mì, hai chén đã đi hết sáu văn tiền, chỉ còn lại hai văn tiền, không còn tiền ăn thêm nữa.<br><br>Nàng trả tiền cho chủ quán xong, vừa nghĩ xem làm thế nào để kiếm tiền vừa nhìn oắt con nhà mình an ủi: \"Bảo Bảo, buổi tối chúng ta sẽ ăn nhiều hơn chút, hiện tại chịu khó nhịn vậy.\"<br><br>\"Nương, con đã ăn no, không đói bụng nữa.\" Thằng nhóc hít hít bụng, vẻ mặt thành thật nói.<br><br>Mễ Vị làm sao không biết nó đang nói dối, cũng không vạch trần nó, trong lòng nhanh chóng nghĩ làm thế nào kiếm tiền.<br><br>Nàng cũng không có tay nghề gì khác, nghĩ tới nghĩ lui, trừ lấy ra thủ nghệ vốn có của mình, thật không còn cách nào khác.<br><br>Nói đến thủ nghệ vốn có này, liền không thể không nói đến kiếp trước của nàng. Kiếp trước nàng là một cô nhi, sau khi tốt nghiệp trung học cũng không đi học lên nữa, một là vì điều kiện không cho phép, hai là vì nàng cũng không có mấy hứng thú với chuyện học tập, nhưng nàng lại đặc biệt hứng thú với trù nghệ, luôn muốn trở thành một mỹ thực gia siêu cấp.<br><br>Sau này nàng liền cố gắng theo con đường này, bắt đầu từ chuyện làm nhân viên phục vụ cho mấy tiệm cơm nhỏ, sau đó lại làm vị trí chạy vặt trong bếp, rồi đến học việc ở mấy bếp của nhà hàng, mỗi ngày đều cẩn thận làm việc, đồng thời càng không ngừng học tập các loại trù nghệ. Mỗi ngày trừ ăn cơm với ngủ ra, đều suy nghĩ về trù nghệ, rốt cuộc cố gắng cũng không phụ lòng người, thủ nghệ nàng càng ngày càng tốt, cũng được công nhận, được một đầu bếp trứ danh thu làm đồ đệ. Trải qua mười mấy năm, nàng liền trò giỏi hơn thầy, cuối cùng tạo dựng được tên tuổi của riêng mình, sáng lập ra một nền ẩm thực mới được toàn quốc thậm chí cả thế giới công nhận, đứng trên đỉnh của con đường mỹ thực.<br><br>Nhưng con đường phấn đấu này đi thật sự quá mệt mỏi, kiếp trước nàng vẫn mới qua 30 tuổi liền bệnh hoạn quấn thân, thân thể mười phần không tốt, sau này nàng dứt khoát giao lại sản nghiệp cho đồ đệ, chuẩn bị để bản thân rút lui sống những ngày tháng tốt đẹp sau cùng, nhưng ngày tháng tốt đẹp còn chưa được bắt đầu, thì đã đi đời nhà ma sau một lần tai nạn xe cô, sau đó lại bị đá đến cái thời đại này.<br><br>Đại khái là vì kiếp trước quá mệt mỏi, đời này nàng chỉ muốn sống thoải mái vui sướng, cho nên liền sống đời cá mặn nhiều năm, nào biết hiện tại vẫn phải cần đến cái thủ nghệ này để lo ăn lo uống, lại phát sầu.<br><br>Vừa nghĩ, nàng vừa quan sát mấy đồ ăn trên đường phố, sau đó nàng liền phát hiện, đồ ăn trên đường cơ bản chỉ là mấy loại mì cháo, còn không thì chỉ có các loại bánh bột ngô.<br><br>Như vậy, nàng có thể làm một số món ăn không giống bình thường, như vậy lÀ có thể bán được rồi.<br><br>Nhưng mà, để làm được đồ ăn, đầu tiên phải có vốn, mà hai văn tiền trong túi nàng khẳng định là không đủ.<br><br>Cho nên, trước tiên phải nghĩ biện pháp khởi động chút tài chính mới được.<br><br>Tài chính... Nàng không khỏi ném ánh mắt về phía oắt con nhà mình, nở nụ cười, \"Tiểu Đầu Trọc, chúng ta đi kiếm tiền đi!\"';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: visible
            ? AppBar(
                backgroundColor: Colors.white,
                title: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    new TextSpan(
                        text:
                            "This is the story name but it's so longgggggggggggggggggg",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold))
                  ]),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 25,
                    color: Colors.blue,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        print("user clicks to refresh");
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.blue,
                      ))
                ],
              )
            : null,
        backgroundColor: Colors.white,
        persistentFooterButtons: visible
            ? [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        pushNewScreen(context,
                            screen: MenuChapters(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino);
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )
              ]
            : null,
        body: GestureDetector(
          onTap: () {
            setState(() {
              print("show/hide navbar");
              this.visible = !this.visible;
            });
          },
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: visible ? 0 : 56,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Chương 1 ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Html(data: testHTML, style: {
                      "body": Style(
                          color: Colors.black, fontSize: FontSize.rem(1.15))
                    }),
                    Container(
                      margin: EdgeInsets.only(bottom: 50, top: 20),
                      child: Center(
                        child: Text(
                          "--- 1/70 ---",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
