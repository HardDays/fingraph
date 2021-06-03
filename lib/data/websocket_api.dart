import 'dart:convert';
import 'package:fingraph/model/dimension_type.dart';
import 'package:fingraph/model/ohlc.dart';
import 'package:fingraph/model/request_args.dart';
import 'package:fingraph/model/tick.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'get_from_web.dart';

import '../model/src_api.dart';
import '../model/asset.dart';
import '../utils/const.dart';

class WebSocketSrc implements SrcApi {
  @override
  RequestArgs _requestArgs;
  RequestArgs get requestArgs => _requestArgs;
  set requestArgs(RequestArgs requestArgs) {
    _requestArgs = requestArgs;
  }

  IOWebSocketChannel _channel;

  @override
  Future<List<Asset>> getAssets() async {
    List<Asset> assets = [];
    String jsonString = await GetFromWeb.getJsonWeb(kUrlAssests);
    for (var a in json.decode(jsonString)) {
      assets.add(Asset.fromJson(a));
    }
    return assets;
  }

  @override
  bool start(String symbol, OnData onData, {OnError onError}) {
    bool res = false;
    print("* websocket.start");
    try {
      _channel = IOWebSocketChannel.connect(Uri.parse("$kWsUrlQuotes?token=$kWsToken"));
      _channel.stream.listen(onData, cancelOnError: true, onError: onError, onDone: _onDone);
      //_channel.stream.listen(_testData, cancelOnError: false, onError: _onError, onDone: _onDone);
      print("* websocket.listen");

      const _request = kWsExampleFirstQuery;
      _channel.sink.add(_request);

      print("* websocket.sink.add($_request)");
      res = true;
    } catch (e) {
      print("* websocket.catch error: ${e.toString()}");
    }
    return res;
  }

  // void _testData(dynamic msg) => print("* websocket.onData: ${msg.toString()}");
  // void _onError(Object error) => print("* websocket._onError: $error");
  void _onDone() => print("* websocket._onDone");

  @override
  void stop() {
    print("* websocket.stop");
    _channel.sink.close(status.goingAway);
  }

  @override
  Future<List<dynamic>> getHistory(RequestArgs ra) {
    List<dynamic> data = [];
    String jsonString;
    if(ra.type == DimensionType.tick) {
      jsonString = '[{"d":1620346800966,"q":0.94633},{"d":1620346801561,"q":0.94633},{"d":1620346802561,"q":0.94633},{"d":1620346803562,"q":0.94633},{"d":1620346804661,"q":0.94632},{"d":1620346805663,"q":0.94632},{"d":1620346806661,"q":0.94633},{"d":1620346807662,"q":0.94633},{"d":1620346808662,"q":0.94633},{"d":1620346809664,"q":0.94633},{"d":1620346810664,"q":0.94633},{"d":1620346811666,"q":0.94633},{"d":1620346812666,"q":0.94633},{"d":1620346813667,"q":0.94633},{"d":1620346814669,"q":0.94633},{"d":1620346815670,"q":0.94633},{"d":1620346816672,"q":0.94633},{"d":1620346817962,"q":0.94629},{"d":1620346818962,"q":0.94627},{"d":1620346819963,"q":0.94627},{"d":1620346820964,"q":0.94627},{"d":1620346821960,"q":0.94629},{"d":1620346822961,"q":0.94631},{"d":1620346823861,"q":0.94628},{"d":1620346824861,"q":0.94628},{"d":1620346825861,"q":0.94628},{"d":1620346826862,"q":0.94628},{"d":1620346827661,"q":0.94629},{"d":1620346828663,"q":0.94629},{"d":1620346829664,"q":0.94629},{"d":1620346830666,"q":0.94629},{"d":1620346831666,"q":0.94629},{"d":1620346832667,"q":0.94629},{"d":1620346833668,"q":0.94629},{"d":1620346834861,"q":0.94629},{"d":1620346835863,"q":0.94629},{"d":1620346836864,"q":0.94629},{"d":1620346837865,"q":0.94629},{"d":1620346838865,"q":0.94629},{"d":1620346839661,"q":0.94629},{"d":1620346840662,"q":0.94629},{"d":1620346841662,"q":0.94629},{"d":1620346842664,"q":0.94629},{"d":1620346843664,"q":0.94629},{"d":1620346844666,"q":0.94629},{"d":1620346845668,"q":0.94629},{"d":1620346846669,"q":0.94629},{"d":1620346847670,"q":0.94629},{"d":1620346848672,"q":0.94629},{"d":1620346849673,"q":0.94629},{"d":1620346850675,"q":0.94629},{"d":1620346851675,"q":0.94629},{"d":1620346852676,"q":0.94629},{"d":1620346853761,"q":0.94629},{"d":1620346854560,"q":0.94629},{"d":1620346855561,"q":0.94629},{"d":1620346856562,"q":0.94629},{"d":1620346857562,"q":0.94629},{"d":1620346858563,"q":0.94629},{"d":1620346859661,"q":0.9463},{"d":1620346860662,"q":0.9463},{"d":1620346861762,"q":0.94629},{"d":1620346862763,"q":0.94629},{"d":1620346863962,"q":0.94629},{"d":1620346864964,"q":0.94629},{"d":1620346865965,"q":0.94629},{"d":1620346866966,"q":0.94629},{"d":1620346867968,"q":0.94629},{"d":1620346868968,"q":0.94629},{"d":1620346869969,"q":0.94629},{"d":1620346870860,"q":0.9463},{"d":1620346871862,"q":0.9463},{"d":1620346872862,"q":0.9463},{"d":1620346873863,"q":0.9463},{"d":1620346874863,"q":0.9463},{"d":1620346875864,"q":0.9463},{"d":1620346876861,"q":0.94625},{"d":1620346877862,"q":0.94625},{"d":1620346878862,"q":0.94627},{"d":1620346879861,"q":0.94624},{"d":1620346880760,"q":0.94625},{"d":1620346881762,"q":0.94625},{"d":1620346882764,"q":0.94625},{"d":1620346883765,"q":0.94625},{"d":1620346884766,"q":0.94625},{"d":1620346885768,"q":0.94625},{"d":1620346886768,"q":0.94625},{"d":1620346887769,"q":0.94625},{"d":1620346888770,"q":0.94625},{"d":1620346889771,"q":0.94625},{"d":1620346890773,"q":0.94625},{"d":1620346891961,"q":0.94625},{"d":1620346892961,"q":0.94625},{"d":1620346893963,"q":0.94625},{"d":1620346894964,"q":0.94625},{"d":1620346895966,"q":0.94625},{"d":1620346896968,"q":0.94625},{"d":1620346897969,"q":0.94625},{"d":1620346898971,"q":0.94625},{"d":1620346899972,"q":0.94625},{"d":1620346900974,"q":0.94625},{"d":1620346901975,"q":0.94625},{"d":1620346902976,"q":0.94625},{"d":1620346903978,"q":0.94625},{"d":1620346904980,"q":0.94625},{"d":1620346905982,"q":0.94625},{"d":1620346906984,"q":0.94625},{"d":1620346907761,"q":0.94624},{"d":1620346908760,"q":0.94625},{"d":1620346909761,"q":0.94625},{"d":1620346910762,"q":0.94625},{"d":1620346911762,"q":0.94625},{"d":1620346912763,"q":0.94625},{"d":1620346913760,"q":0.94619},{"d":1620346914662,"q":0.9462},{"d":1620346915664,"q":0.9462},{"d":1620346916960,"q":0.94617},{"d":1620346917861,"q":0.9462},{"d":1620346918961,"q":0.94615},{"d":1620346919961,"q":0.94615},{"d":1620346920962,"q":0.94615},{"d":1620346921964,"q":0.94615},{"d":1620346922861,"q":0.94613},{"d":1620346923863,"q":0.94613},{"d":1620346924960,"q":0.94613},{"d":1620346925661,"q":0.94613},{"d":1620346926661,"q":0.94613},{"d":1620346927662,"q":0.94613},{"d":1620346928663,"q":0.94613},{"d":1620346929664,"q":0.94613},{"d":1620346930665,"q":0.94613},{"d":1620346931862,"q":0.94612},{"d":1620346932661,"q":0.94612},{"d":1620346933560,"q":0.94611},{"d":1620346934860,"q":0.9461},{"d":1620346935861,"q":0.9461},{"d":1620346936862,"q":0.9461},{"d":1620346937863,"q":0.9461},{"d":1620346938761,"q":0.94613},{"d":1620346939762,"q":0.94613},{"d":1620346940762,"q":0.94613},{"d":1620346941763,"q":0.94613},{"d":1620346942764,"q":0.94613},{"d":1620346943765,"q":0.94613},{"d":1620346944766,"q":0.94613},{"d":1620346945767,"q":0.94613},{"d":1620346946768,"q":0.94613},{"d":1620346947961,"q":0.94618},{"d":1620346948762,"q":0.94617},{"d":1620346949764,"q":0.94617},{"d":1620346950765,"q":0.94617},{"d":1620346951961,"q":0.94618},{"d":1620346952860,"q":0.94618},{"d":1620346953762,"q":0.94617},{"d":1620346954861,"q":0.94618},{"d":1620346955862,"q":0.94618},{"d":1620346956863,"q":0.94618},{"d":1620346957560,"q":0.94619},{"d":1620346958562,"q":0.94619},{"d":1620346959861,"q":0.94619},{"d":1620346960861,"q":0.94619},{"d":1620346961861,"q":0.94619},{"d":1620346962963,"q":0.94617},{"d":1620346963562,"q":0.94616},{"d":1620346964761,"q":0.94618},{"d":1620346965762,"q":0.94618},{"d":1620346966764,"q":0.94618},{"d":1620346967764,"q":0.94618},{"d":1620346968765,"q":0.94618},{"d":1620346969762,"q":0.94619},{"d":1620346970763,"q":0.94619},{"d":1620346971661,"q":0.94619},{"d":1620346972861,"q":0.94619},{"d":1620346973862,"q":0.94619},{"d":1620346974863,"q":0.94619},{"d":1620346975662,"q":0.9462},{"d":1620346976663,"q":0.9462},{"d":1620346977664,"q":0.9462},{"d":1620346978666,"q":0.9462},{"d":1620346979667,"q":0.9462},{"d":1620346980661,"q":0.94619},{"d":1620346981662,"q":0.94619},{"d":1620346982664,"q":0.94619},{"d":1620346983665,"q":0.94619},{"d":1620346984666,"q":0.94619},{"d":1620346985668,"q":0.94619},{"d":1620346986669,"q":0.94619},{"d":1620346987661,"q":0.9462},{"d":1620346988961,"q":0.9462},{"d":1620346989660,"q":0.94627},{"d":1620346990662,"q":0.94627},{"d":1620346991663,"q":0.94627},{"d":1620346992664,"q":0.94627},{"d":1620346993665,"q":0.94627},{"d":1620346994961,"q":0.94627},{"d":1620346995962,"q":0.94627},{"d":1620346996963,"q":0.94627},{"d":1620346997963,"q":0.94627},{"d":1620346998660,"q":0.94627},{"d":1620346999662,"q":0.94627},{"d":1620347000663,"q":0.94627},{"d":1620347001665,"q":0.94627},{"d":1620347002666,"q":0.94627},{"d":1620347003667,"q":0.94627},{"d":1620347004668,"q":0.94627},{"d":1620347005670,"q":0.94627},{"d":1620347006860,"q":0.94627},{"d":1620347007862,"q":0.94627},{"d":1620347008864,"q":0.94627},{"d":1620347009560,"q":0.94623},{"d":1620347010561,"q":0.94623},{"d":1620347011562,"q":0.94623},{"d":1620347012564,"q":0.94623},{"d":1620347013565,"q":0.94623},{"d":1620347014567,"q":0.94623},{"d":1620347015860,"q":0.94621},{"d":1620347016862,"q":0.94621},{"d":1620347017864,"q":0.94621},{"d":1620347018865,"q":0.94621},{"d":1620347019961,"q":0.94622},{"d":1620347020963,"q":0.94622},{"d":1620347021661,"q":0.94621},{"d":1620347022662,"q":0.94621},{"d":1620347023663,"q":0.94621},{"d":1620347024664,"q":0.94621},{"d":1620347025665,"q":0.94621},{"d":1620347026666,"q":0.94621},{"d":1620347027667,"q":0.94621},{"d":1620347028668,"q":0.94621},{"d":1620347029661,"q":0.94619},{"d":1620347030662,"q":0.94619},{"d":1620347031663,"q":0.94619},{"d":1620347032665,"q":0.94619},{"d":1620347033661,"q":0.94617},{"d":1620347034961,"q":0.94618},{"d":1620347035961,"q":0.94618},{"d":1620347036963,"q":0.94618},{"d":1620347037964,"q":0.94618},{"d":1620347038965,"q":0.94618},{"d":1620347039966,"q":0.94618},{"d":1620347040761,"q":0.94617},{"d":1620347041761,"q":0.94617},{"d":1620347042762,"q":0.94617},{"d":1620347043763,"q":0.94617},{"d":1620347044764,"q":0.94617},{"d":1620347045765,"q":0.94617},{"d":1620347046765,"q":0.94617},{"d":1620347047661,"q":0.94617},{"d":1620347048663,"q":0.94617},{"d":1620347049664,"q":0.94617},{"d":1620347050665,"q":0.94617},{"d":1620347051666,"q":0.94617},{"d":1620347052668,"q":0.94617},{"d":1620347053668,"q":0.94617},{"d":1620347054669,"q":0.94617},{"d":1620347055661,"q":0.94617},{"d":1620347056661,"q":0.94617},{"d":1620347057663,"q":0.94617},{"d":1620347058660,"q":0.94616},{"d":1620347059663,"q":0.94616},{"d":1620347060663,"q":0.94616},{"d":1620347061665,"q":0.94616},{"d":1620347062666,"q":0.94616},{"d":1620347063668,"q":0.94616},{"d":1620347064668,"q":0.94616},{"d":1620347065861,"q":0.94618},{"d":1620347066863,"q":0.94618},{"d":1620347067865,"q":0.94618},{"d":1620347068867,"q":0.94618},{"d":1620347069868,"q":0.94618},{"d":1620347070870,"q":0.94618},{"d":1620347071870,"q":0.94618},{"d":1620347072872,"q":0.94618},{"d":1620347073873,"q":0.94618},{"d":1620347074874,"q":0.94618},{"d":1620347075661,"q":0.94621},{"d":1620347076661,"q":0.94621},{"d":1620347077663,"q":0.94621},{"d":1620347078663,"q":0.94621},{"d":1620347079664,"q":0.94621},{"d":1620347080666,"q":0.94621},{"d":1620347081667,"q":0.94621},{"d":1620347082961,"q":0.94619},{"d":1620347083965,"q":0.94619},{"d":1620347084967,"q":0.94619},{"d":1620347085968,"q":0.94619},{"d":1620347086969,"q":0.94619},{"d":1620347087970,"q":0.94619},{"d":1620347088862,"q":0.94621},{"d":1620347089660,"q":0.9462},{"d":1620347090662,"q":0.9462},{"d":1620347091663,"q":0.9462},{"d":1620347092664,"q":0.9462},{"d":1620347093664,"q":0.9462},{"d":1620347094665,"q":0.9462},{"d":1620347095666,"q":0.9462},{"d":1620347096668,"q":0.9462},{"d":1620347097960,"q":0.94618},{"d":1620347098562,"q":0.94617},{"d":1620347099562,"q":0.94617}]';
      for (var a in json.decode(jsonString)) {
        data.add(Tick.fromJson(a));
      }
    } else {
      jsonString = '[{"c":0.94659,"d":1620345600000,"h":0.94671,"l":0.94647,"o":0.94661},{"c":0.9467,"d":1620345720000,"h":0.94677,"l":0.94656,"o":0.94659},{"c":0.94669,"d":1620345840000,"h":0.94672,"l":0.94665,"o":0.9467},{"c":0.94665,"d":1620345960000,"h":0.94679,"l":0.94662,"o":0.94669},{"c":0.94663,"d":1620346080000,"h":0.94671,"l":0.94659,"o":0.94665},{"c":0.94649,"d":1620346200000,"h":0.94672,"l":0.94649,"o":0.94663},{"c":0.94645,"d":1620346320000,"h":0.94649,"l":0.94635,"o":0.94649},{"c":0.9466,"d":1620346440000,"h":0.9466,"l":0.94637,"o":0.94645},{"c":0.94649,"d":1620346560000,"h":0.9466,"l":0.94649,"o":0.9466},{"c":0.94633,"d":1620346680000,"h":0.94651,"l":0.94633,"o":0.94649},{"c":0.94615,"d":1620346800000,"h":0.94633,"l":0.94615,"o":0.94633},{"c":0.94618,"d":1620346920000,"h":0.94627,"l":0.9461,"o":0.94615},{"c":0.94616,"d":1620347040000,"h":0.94621,"l":0.94614,"o":0.94618},{"c":0.94615,"d":1620347160000,"h":0.94618,"l":0.94615,"o":0.94616},{"c":0.94609,"d":1620347280000,"h":0.94615,"l":0.94602,"o":0.94615},{"c":0.94622,"d":1620347400000,"h":0.94622,"l":0.94609,"o":0.94609},{"c":0.94621,"d":1620347520000,"h":0.94627,"l":0.94617,"o":0.94622},{"c":0.94611,"d":1620347640000,"h":0.94624,"l":0.94609,"o":0.94621},{"c":0.94617,"d":1620347760000,"h":0.94625,"l":0.94609,"o":0.94611},{"c":0.94617,"d":1620347880000,"h":0.94618,"l":0.94613,"o":0.94617},{"c":0.94615,"d":1620348000000,"h":0.94621,"l":0.94613,"o":0.94617},{"c":0.94615,"d":1620348120000,"h":0.94615,"l":0.9461,"o":0.94615},{"c":0.94623,"d":1620348240000,"h":0.94625,"l":0.9461,"o":0.94615},{"c":0.94635,"d":1620348360000,"h":0.94637,"l":0.94619,"o":0.94623},{"c":0.94641,"d":1620348480000,"h":0.94643,"l":0.94635,"o":0.94635},{"c":0.94639,"d":1620348600000,"h":0.94645,"l":0.94637,"o":0.94641},{"c":0.94618,"d":1620348720000,"h":0.94641,"l":0.94618,"o":0.94639},{"c":0.94597,"d":1620348840000,"h":0.94618,"l":0.94595,"o":0.94618},{"c":0.94596,"d":1620348960000,"h":0.94607,"l":0.94595,"o":0.94597},{"c":0.94597,"d":1620349080000,"h":0.94603,"l":0.94593,"o":0.94596},{"c":0.94601,"d":1620349200000,"h":0.94606,"l":0.94596,"o":0.94597},{"c":0.94603,"d":1620349320000,"h":0.9461,"l":0.946,"o":0.94601},{"c":0.94603,"d":1620349440000,"h":0.94606,"l":0.94597,"o":0.94603},{"c":0.94596,"d":1620349560000,"h":0.94603,"l":0.94585,"o":0.94603},{"c":0.94598,"d":1620349680000,"h":0.94598,"l":0.94586,"o":0.94596},{"c":0.94599,"d":1620349800000,"h":0.94601,"l":0.94591,"o":0.94598},{"c":0.94607,"d":1620349920000,"h":0.94607,"l":0.94597,"o":0.94599},{"c":0.94607,"d":1620350040000,"h":0.94612,"l":0.94601,"o":0.94607},{"c":0.94595,"d":1620350160000,"h":0.94625,"l":0.94593,"o":0.94607},{"c":0.94598,"d":1620350280000,"h":0.94607,"l":0.94595,"o":0.94595},{"c":0.94591,"d":1620350400000,"h":0.94599,"l":0.94589,"o":0.94598},{"c":0.94589,"d":1620350520000,"h":0.94593,"l":0.94585,"o":0.94591},{"c":0.94593,"d":1620350640000,"h":0.94597,"l":0.94589,"o":0.94589},{"c":0.94595,"d":1620350760000,"h":0.94596,"l":0.94589,"o":0.94593},{"c":0.94591,"d":1620350880000,"h":0.94597,"l":0.94589,"o":0.94595},{"c":0.94625,"d":1620351000000,"h":0.94625,"l":0.94583,"o":0.94591},{"c":0.94651,"d":1620351120000,"h":0.94665,"l":0.94625,"o":0.94625},{"c":0.94644,"d":1620351240000,"h":0.94655,"l":0.94631,"o":0.94651},{"c":0.94627,"d":1620351360000,"h":0.94646,"l":0.94627,"o":0.94644},{"c":0.94609,"d":1620351480000,"h":0.94629,"l":0.94609,"o":0.94627},{"c":0.94619,"d":1620351600000,"h":0.94619,"l":0.94607,"o":0.94609},{"c":0.94649,"d":1620351720000,"h":0.94653,"l":0.94615,"o":0.94619},{"c":0.94675,"d":1620351840000,"h":0.94685,"l":0.94649,"o":0.94649},{"c":0.94684,"d":1620351960000,"h":0.9469,"l":0.94675,"o":0.94675},{"c":0.94647,"d":1620352080000,"h":0.94685,"l":0.94635,"o":0.94684},{"c":0.94643,"d":1620352200000,"h":0.94656,"l":0.94639,"o":0.94647},{"c":0.94657,"d":1620352320000,"h":0.94663,"l":0.94638,"o":0.94643},{"c":0.94625,"d":1620352440000,"h":0.94662,"l":0.94623,"o":0.94657},{"c":0.94613,"d":1620352560000,"h":0.94625,"l":0.94605,"o":0.94625},{"c":0.94621,"d":1620352680000,"h":0.94621,"l":0.94608,"o":0.94613},{"c":0.94657,"d":1620352800000,"h":0.94659,"l":0.94617,"o":0.94621},{"c":0.94631,"d":1620352920000,"h":0.94659,"l":0.94631,"o":0.94657},{"c":0.94607,"d":1620353040000,"h":0.94633,"l":0.94603,"o":0.94631},{"c":0.94611,"d":1620353160000,"h":0.94618,"l":0.94602,"o":0.94607},{"c":0.94605,"d":1620353280000,"h":0.94613,"l":0.94597,"o":0.94611},{"c":0.94605,"d":1620353400000,"h":0.94607,"l":0.94597,"o":0.94605},{"c":0.94589,"d":1620353520000,"h":0.94605,"l":0.94583,"o":0.94605},{"c":0.94571,"d":1620353640000,"h":0.94589,"l":0.9457,"o":0.94589},{"c":0.94553,"d":1620353760000,"h":0.94575,"l":0.94546,"o":0.94571},{"c":0.94572,"d":1620353880000,"h":0.94577,"l":0.94551,"o":0.94553},{"c":0.94587,"d":1620354000000,"h":0.94592,"l":0.9457,"o":0.94572},{"c":0.94587,"d":1620354120000,"h":0.94594,"l":0.94578,"o":0.94587},{"c":0.94585,"d":1620354240000,"h":0.94591,"l":0.9458,"o":0.94587},{"c":0.94577,"d":1620354360000,"h":0.94589,"l":0.94577,"o":0.94585},{"c":0.94577,"d":1620354480000,"h":0.94581,"l":0.94573,"o":0.94577},{"c":0.94555,"d":1620354600000,"h":0.94578,"l":0.94553,"o":0.94577},{"c":0.94545,"d":1620354720000,"h":0.94557,"l":0.94539,"o":0.94555},{"c":0.94539,"d":1620354840000,"h":0.94549,"l":0.94527,"o":0.94545},{"c":0.94545,"d":1620354960000,"h":0.94545,"l":0.94532,"o":0.94539},{"c":0.94549,"d":1620355080000,"h":0.94563,"l":0.94541,"o":0.94545},{"c":0.94543,"d":1620355200000,"h":0.94553,"l":0.94539,"o":0.94549},{"c":0.94542,"d":1620355320000,"h":0.94548,"l":0.94539,"o":0.94543},{"c":0.94549,"d":1620355440000,"h":0.94555,"l":0.94542,"o":0.94542},{"c":0.94541,"d":1620355560000,"h":0.94552,"l":0.94541,"o":0.94549},{"c":0.94543,"d":1620355680000,"h":0.94548,"l":0.94535,"o":0.94541},{"c":0.94543,"d":1620355800000,"h":0.94549,"l":0.9454,"o":0.94543},{"c":0.94551,"d":1620355920000,"h":0.94555,"l":0.94543,"o":0.94543},{"c":0.94553,"d":1620356040000,"h":0.9456,"l":0.94551,"o":0.94551},{"c":0.94551,"d":1620356160000,"h":0.94556,"l":0.94547,"o":0.94553},{"c":0.94557,"d":1620356280000,"h":0.94559,"l":0.94551,"o":0.94551}]';
      for (var a in json.decode(jsonString)) {
        data.add(Ohlc.fromJson(a));
      }
    }
    return Future.value(data);
  }

}

