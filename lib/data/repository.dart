import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/ohlc.dart';
import '../model/quote.dart';

// const chunk1 = [{"d":1620345609863,"q":0.94657},{"d":1620345619963,"q":0.94655},{"d":1620345629661,"q":0.94647},{"d":1620345639661,"q":0.94661},{"d":1620345649862,"q":0.94659},{"d":1620345659761,"q":0.94658},{"d":1620345669960,"q":0.94669}];
// //const chunk1 = [{"d":1620345609863,"q":0.94657},{"d":1620345619963,"q":0.94655},{"d":1620345629661,"q":0.94647},{"d":1620345639661,"q":0.94661},{"d":1620345649862,"q":0.94659},{"d":1620345659761,"q":0.94658},{"d":1620345669960,"q":0.94669},{"d":1620345679561,"q":0.94661},{"d":1620345689962,"q":0.94667},{"d":1620345699961,"q":0.94663},{"d":1620345709764,"q":0.94664},{"d":1620345719960,"q":0.94659},{"d":1620345729762,"q":0.94657},{"d":1620345739560,"q":0.94661},{"d":1620345749964,"q":0.94661},{"d":1620345759966,"q":0.94665},{"d":1620345769666,"q":0.94664},{"d":1620345779964,"q":0.94664},{"d":1620345789962,"q":0.94666},{"d":1620345799961,"q":0.94667},{"d":1620345809962,"q":0.94671},{"d":1620345819661,"q":0.94676},{"d":1620345829962,"q":0.94677},{"d":1620345839962,"q":0.9467},{"d":1620345849864,"q":0.94671},{"d":1620345859863,"q":0.94671},{"d":1620345869960,"q":0.9467},{"d":1620345879863,"q":0.94668},{"d":1620345889763,"q":0.94665},{"d":1620345899962,"q":0.94665},{"d":1620345909760,"q":0.94667},{"d":1620345919861,"q":0.94667},{"d":1620345929960,"q":0.94669},{"d":1620345939762,"q":0.94671},{"d":1620345949561,"q":0.94671},{"d":1620345959666,"q":0.94669},{"d":1620345969965,"q":0.9467},{"d":1620345979762,"q":0.94669},{"d":1620345989861,"q":0.94672},{"d":1620345999961,"q":0.94671},{"d":1620346009861,"q":0.94669},{"d":1620346019861,"q":0.94667},{"d":1620346029971,"q":0.94667},{"d":1620346039963,"q":0.94678},{"d":1620346049760,"q":0.94667},{"d":1620346059665,"q":0.94663},{"d":1620346069661,"q":0.94665},{"d":1620346079766,"q":0.94665},{"d":1620346089860,"q":0.94667},{"d":1620346099766,"q":0.94663},{"d":1620346109962,"q":0.94663},{"d":1620346119661,"q":0.94664},{"d":1620346129760,"q":0.94669},{"d":1620346139960,"q":0.94667},{"d":1620346149867,"q":0.94668},{"d":1620346159766,"q":0.94664},{"d":1620346169862,"q":0.94665},{"d":1620346179660,"q":0.94662},{"d":1620346189660,"q":0.94659},{"d":1620346199964,"q":0.94663},{"d":1620346209863,"q":0.94667},{"d":1620346219563,"q":0.94667},{"d":1620346229660,"q":0.94665},{"d":1620346239561,"q":0.94666},{"d":1620346249760,"q":0.9466},{"d":1620346259561,"q":0.94661},{"d":1620346269864,"q":0.94657},{"d":1620346279861,"q":0.94656},{"d":1620346289864,"q":0.94657},{"d":1620346299864,"q":0.94657},{"d":1620346309660,"q":0.94649},{"d":1620346319862,"q":0.94649},{"d":1620346329661,"q":0.94635},{"d":1620346339861,"q":0.94639},{"d":1620346349960,"q":0.94638},{"d":1620346359766,"q":0.94641},{"d":1620346369664,"q":0.94639},{"d":1620346379675,"q":0.94639},{"d":1620346389764,"q":0.94645},{"d":1620346399660,"q":0.94643},{"d":1620346409870,"q":0.94645},{"d":1620346419567,"q":0.94645},{"d":1620346429971,"q":0.94647},{"d":1620346439866,"q":0.94645},{"d":1620346449664,"q":0.94642},{"d":1620346459865,"q":0.94641},{"d":1620346469879,"q":0.94641},{"d":1620346479892,"q":0.94641},{"d":1620346489764,"q":0.94637},{"d":1620346499570,"q":0.94637},{"d":1620346509662,"q":0.94643},{"d":1620346519961,"q":0.94651},{"d":1620346529963,"q":0.94653},{"d":1620346539960,"q":0.94656},{"d":1620346549662,"q":0.94658},{"d":1620346559963,"q":0.9466},{"d":1620346569671,"q":0.94659},{"d":1620346579763,"q":0.94659},{"d":1620346589960,"q":0.94659},{"d":1620346599663,"q":0.94657},{"d":1620346609569,"q":0.94653},{"d":1620346619583,"q":0.94653},{"d":1620346629596,"q":0.94653},{"d":1620346639962,"q":0.94653},{"d":1620346649564,"q":0.94655},{"d":1620346659664,"q":0.94651},{"d":1620346669862,"q":0.94651},{"d":1620346679966,"q":0.94649},{"d":1620346689567,"q":0.94645},{"d":1620346699763,"q":0.94641},{"d":1620346709764,"q":0.94645},{"d":1620346719664,"q":0.94644},{"d":1620346729562,"q":0.94644},{"d":1620346739572,"q":0.94644},{"d":1620346749666,"q":0.94644},{"d":1620346759861,"q":0.94642},{"d":1620346769872,"q":0.94642},{"d":1620346779560,"q":0.94636},{"d":1620346789770,"q":0.94638},{"d":1620346799965,"q":0.94633},{"d":1620346809664,"q":0.94633},{"d":1620346819963,"q":0.94627},{"d":1620346829664,"q":0.94629},{"d":1620346839661,"q":0.94629},{"d":1620346849673,"q":0.94629},{"d":1620346859661,"q":0.9463},{"d":1620346869969,"q":0.94629},{"d":1620346879861,"q":0.94624},{"d":1620346889771,"q":0.94625},{"d":1620346899972,"q":0.94625},{"d":1620346909761,"q":0.94625},{"d":1620346919961,"q":0.94615},{"d":1620346929664,"q":0.94613},{"d":1620346939762,"q":0.94613},{"d":1620346949764,"q":0.94617},{"d":1620346959861,"q":0.94619},{"d":1620346969762,"q":0.94619},{"d":1620346979667,"q":0.9462},{"d":1620346989660,"q":0.94627},{"d":1620346999662,"q":0.94627},{"d":1620347009560,"q":0.94623},{"d":1620347019961,"q":0.94622},{"d":1620347029661,"q":0.94619},{"d":1620347039966,"q":0.94618},{"d":1620347049664,"q":0.94617},{"d":1620347059663,"q":0.94616},{"d":1620347069868,"q":0.94618},{"d":1620347079664,"q":0.94621},{"d":1620347089660,"q":0.9462},{"d":1620347099562,"q":0.94617},{"d":1620347109867,"q":0.94619},{"d":1620347119764,"q":0.94617},{"d":1620347129970,"q":0.94615},{"d":1620347139864,"q":0.94615},{"d":1620347149876,"q":0.94615},{"d":1620347159561,"q":0.94616},{"d":1620347169661,"q":0.94615},{"d":1620347179673,"q":0.94615},{"d":1620347189763,"q":0.94617},{"d":1620347199775,"q":0.94617},{"d":1620347209967,"q":0.94618},{"d":1620347219977,"q":0.94618},{"d":1620347229864,"q":0.94617},{"d":1620347239663,"q":0.94617},{"d":1620347249764,"q":0.94615},{"d":1620347259662,"q":0.94615},{"d":1620347269762,"q":0.94615},{"d":1620347279663,"q":0.94615},{"d":1620347289861,"q":0.94612},{"d":1620347299962,"q":0.94612},{"d":1620347309965,"q":0.94607},{"d":1620347319766,"q":0.94606},{"d":1620347329777,"q":0.94606},{"d":1620347339962,"q":0.94605},{"d":1620347349861,"q":0.94603},{"d":1620347359668,"q":0.94603},{"d":1620347369763,"q":0.94605},{"d":1620347379861,"q":0.94607},{"d":1620347389864,"q":0.94609},{"d":1620347399876,"q":0.94609},{"d":1620347409668,"q":0.94611},{"d":1620347419681,"q":0.94611},{"d":1620347429963,"q":0.94612},{"d":1620347439975,"q":0.94612},{"d":1620347449985,"q":0.94612},{"d":1620347459568,"q":0.94617},{"d":1620347469761,"q":0.94617},{"d":1620347479668,"q":0.94615},{"d":1620347489768,"q":0.94613},{"d":1620347499663,"q":0.94619},{"d":1620347509573,"q":0.94622},{"d":1620347519762,"q":0.94622},{"d":1620347529869,"q":0.94625},{"d":1620347539969,"q":0.94625},{"d":1620347549562,"q":0.94624},{"d":1620347559963,"q":0.94624},{"d":1620347569669,"q":0.94624},{"d":1620347579968,"q":0.94619},{"d":1620347589962,"q":0.94623},{"d":1620347599965,"q":0.94619},{"d":1620347609566,"q":0.94623},{"d":1620347619862,"q":0.94627},{"d":1620347629660,"q":0.94624},{"d":1620347639561,"q":0.94621},{"d":1620347649660,"q":0.94617},{"d":1620347659862,"q":0.94615},{"d":1620347669962,"q":0.94613},{"d":1620347679862,"q":0.94611},{"d":1620347689861,"q":0.94611},{"d":1620347699766,"q":0.94609},{"d":1620347709666,"q":0.94615},{"d":1620347719665,"q":0.94613},{"d":1620347729861,"q":0.94613},{"d":1620347739876,"q":0.94613},{"d":1620347749662,"q":0.94611},{"d":1620347759675,"q":0.94611},{"d":1620347769870,"q":0.94612},{"d":1620347779862,"q":0.94613},{"d":1620347789973,"q":0.94614},{"d":1620347799966,"q":0.94615},{"d":1620347809761,"q":0.94621},{"d":1620347819661,"q":0.94622},{"d":1620347829961,"q":0.94622},{"d":1620347839864,"q":0.94625},{"d":1620347849666,"q":0.94625},{"d":1620347859962,"q":0.94619},{"d":1620347869666,"q":0.94617},{"d":1620347879680,"q":0.94617},{"d":1620347889661,"q":0.94616},{"d":1620347899673,"q":0.94616},{"d":1620347909686,"q":0.94616},{"d":1620347919563,"q":0.94617},{"d":1620347929665,"q":0.94615},{"d":1620347939762,"q":0.94617},{"d":1620347949765,"q":0.94618},{"d":1620347959779,"q":0.94618},{"d":1620347969792,"q":0.94618},{"d":1620347979662,"q":0.94615},{"d":1620347989675,"q":0.94615},{"d":1620347999871,"q":0.94617},{"d":1620348009962,"q":0.94619},{"d":1620348019563,"q":0.94621},{"d":1620348029573,"q":0.94621},{"d":1620348039862,"q":0.9462},{"d":1620348049561,"q":0.94617},{"d":1620348059767,"q":0.94615},{"d":1620348069663,"q":0.94616},{"d":1620348079563,"q":0.94615},{"d":1620348089760,"q":0.94619},{"d":1620348099663,"q":0.94619},{"d":1620348109561,"q":0.94618},{"d":1620348119760,"q":0.94615},{"d":1620348129860,"q":0.94613},{"d":1620348139962,"q":0.94612},{"d":1620348149961,"q":0.94611},{"d":1620348159662,"q":0.94615},{"d":1620348169662,"q":0.94611},{"d":1620348179664,"q":0.94613},{"d":1620348189664,"q":0.94611},{"d":1620348199677,"q":0.94611},{"d":1620348209861,"q":0.94612},{"d":1620348219570,"q":0.94611},{"d":1620348229670,"q":0.94612},{"d":1620348239970,"q":0.94615},{"d":1620348249961,"q":0.94613},{"d":1620348259769,"q":0.94615},{"d":1620348269862,"q":0.9461},{"d":1620348279963,"q":0.94615},{"d":1620348289563,"q":0.94619},{"d":1620348299761,"q":0.94622},{"d":1620348309664,"q":0.94615},{"d":1620348319761,"q":0.94625},{"d":1620348329961,"q":0.94623},{"d":1620348339962,"q":0.94623},{"d":1620348349962,"q":0.94623},{"d":1620348359961,"q":0.94623},{"d":1620348369772,"q":0.94623},{"d":1620348379961,"q":0.94623},{"d":1620348389661,"q":0.94623},{"d":1620348399762,"q":0.94627},{"d":1620348409965,"q":0.94625},{"d":1620348419865,"q":0.94627},{"d":1620348429762,"q":0.94637},{"d":1620348439767,"q":0.94633},{"d":1620348449663,"q":0.94632},{"d":1620348459766,"q":0.94635},{"d":1620348469963,"q":0.94636},{"d":1620348479664,"q":0.94635},{"d":1620348489674,"q":0.94635},{"d":1620348499965,"q":0.94635},{"d":1620348509563,"q":0.94636},{"d":1620348519771,"q":0.94637},{"d":1620348529782,"q":0.94637},{"d":1620348539561,"q":0.94636},{"d":1620348549763,"q":0.94641},{"d":1620348559565,"q":0.94641},{"d":1620348569561,"q":0.94642},{"d":1620348579866,"q":0.94641},{"d":1620348589866,"q":0.94641},{"d":1620348599861,"q":0.94641},{"d":1620348609764,"q":0.94643},{"d":1620348619665,"q":0.94643},{"d":1620348629561,"q":0.94641},{"d":1620348639961,"q":0.94639},{"d":1620348649772,"q":0.94639},{"d":1620348659766,"q":0.94639},{"d":1620348669561,"q":0.94639},{"d":1620348679968,"q":0.94641},{"d":1620348689968,"q":0.94643},{"d":1620348699962,"q":0.94641},{"d":1620348709972,"q":0.94644},{"d":1620348719761,"q":0.94639},{"d":1620348729665,"q":0.94636},{"d":1620348739661,"q":0.9464},{"d":1620348749563,"q":0.94637},{"d":1620348759863,"q":0.94638},{"d":1620348769664,"q":0.94637},{"d":1620348779861,"q":0.94637},{"d":1620348789964,"q":0.9463},{"d":1620348799761,"q":0.94627},{"d":1620348809774,"q":0.94627},{"d":1620348819562,"q":0.94623},{"d":1620348829861,"q":0.94621},{"d":1620348839966,"q":0.94618},{"d":1620348849961,"q":0.94613},{"d":1620348859860,"q":0.94609},{"d":1620348869861,"q":0.94607},{"d":1620348879861,"q":0.94605},{"d":1620348889960,"q":0.94601},{"d":1620348899562,"q":0.94606},{"d":1620348909560,"q":0.94601},{"d":1620348919761,"q":0.946},{"d":1620348929562,"q":0.94602},{"d":1620348939961,"q":0.94599},{"d":1620348949763,"q":0.94601},{"d":1620348959968,"q":0.94597},{"d":1620348969663,"q":0.94597},{"d":1620348979762,"q":0.94599},{"d":1620348989563,"q":0.94595},{"d":1620348999864,"q":0.94599},{"d":1620349009877,"q":0.94599},{"d":1620349019966,"q":0.94599},{"d":1620349029562,"q":0.94602},{"d":1620349039862,"q":0.94601},{"d":1620349049664,"q":0.94599},{"d":1620349059673,"q":0.94599},{"d":1620349069764,"q":0.94598},{"d":1620349079562,"q":0.94596},{"d":1620349089667,"q":0.94595},{"d":1620349099666,"q":0.94594},{"d":1620349109562,"q":0.94597},{"d":1620349119861,"q":0.94594},{"d":1620349129666,"q":0.94595},{"d":1620349139567,"q":0.94595},{"d":1620349149965,"q":0.94593},{"d":1620349159568,"q":0.94595},{"d":1620349169961,"q":0.94599},{"d":1620349179665,"q":0.94598},{"d":1620349189861,"q":0.94597},{"d":1620349199874,"q":0.94597}];
// const chunk2 = [{"c":0.94659,"d":1620345600000,"h":0.94671,"l":0.94647,"o":0.94661},{"c":0.9467,"d":1620345720000,"h":0.94677,"l":0.94656,"o":0.94659},{"c":0.94669,"d":1620345840000,"h":0.94672,"l":0.94665,"o":0.9467},{"c":0.94665,"d":1620345960000,"h":0.94679,"l":0.94662,"o":0.94669},{"c":0.94663,"d":1620346080000,"h":0.94671,"l":0.94659,"o":0.94665},{"c":0.94649,"d":1620346200000,"h":0.94672,"l":0.94649,"o":0.94663},{"c":0.94645,"d":1620346320000,"h":0.94649,"l":0.94635,"o":0.94649},{"c":0.9466,"d":1620346440000,"h":0.9466,"l":0.94637,"o":0.94645},{"c":0.94649,"d":1620346560000,"h":0.9466,"l":0.94649,"o":0.9466},{"c":0.94633,"d":1620346680000,"h":0.94651,"l":0.94633,"o":0.94649},{"c":0.94615,"d":1620346800000,"h":0.94633,"l":0.94615,"o":0.94633},{"c":0.94618,"d":1620346920000,"h":0.94627,"l":0.9461,"o":0.94615},{"c":0.94616,"d":1620347040000,"h":0.94621,"l":0.94614,"o":0.94618},{"c":0.94615,"d":1620347160000,"h":0.94618,"l":0.94615,"o":0.94616},{"c":0.94609,"d":1620347280000,"h":0.94615,"l":0.94602,"o":0.94615},{"c":0.94622,"d":1620347400000,"h":0.94622,"l":0.94609,"o":0.94609},{"c":0.94621,"d":1620347520000,"h":0.94627,"l":0.94617,"o":0.94622},{"c":0.94611,"d":1620347640000,"h":0.94624,"l":0.94609,"o":0.94621},{"c":0.94617,"d":1620347760000,"h":0.94625,"l":0.94609,"o":0.94611},{"c":0.94617,"d":1620347880000,"h":0.94618,"l":0.94613,"o":0.94617},{"c":0.94615,"d":1620348000000,"h":0.94621,"l":0.94613,"o":0.94617},{"c":0.94615,"d":1620348120000,"h":0.94615,"l":0.9461,"o":0.94615},{"c":0.94623,"d":1620348240000,"h":0.94625,"l":0.9461,"o":0.94615},{"c":0.94635,"d":1620348360000,"h":0.94637,"l":0.94619,"o":0.94623},{"c":0.94641,"d":1620348480000,"h":0.94643,"l":0.94635,"o":0.94635},{"c":0.94639,"d":1620348600000,"h":0.94645,"l":0.94637,"o":0.94641},{"c":0.94618,"d":1620348720000,"h":0.94641,"l":0.94618,"o":0.94639},{"c":0.94597,"d":1620348840000,"h":0.94618,"l":0.94595,"o":0.94618},{"c":0.94596,"d":1620348960000,"h":0.94607,"l":0.94595,"o":0.94597},{"c":0.94597,"d":1620349080000,"h":0.94603,"l":0.94593,"o":0.94596},{"c":0.94601,"d":1620349200000,"h":0.94606,"l":0.94596,"o":0.94597},{"c":0.94603,"d":1620349320000,"h":0.9461,"l":0.946,"o":0.94601},{"c":0.94603,"d":1620349440000,"h":0.94606,"l":0.94597,"o":0.94603},{"c":0.94596,"d":1620349560000,"h":0.94603,"l":0.94585,"o":0.94603},{"c":0.94598,"d":1620349680000,"h":0.94598,"l":0.94586,"o":0.94596}];
// //const chunk2 = [{"c":0.94659,"d":1620345600000,"h":0.94671,"l":0.94647,"o":0.94661},{"c":0.9467,"d":1620345720000,"h":0.94677,"l":0.94656,"o":0.94659},{"c":0.94669,"d":1620345840000,"h":0.94672,"l":0.94665,"o":0.9467},{"c":0.94665,"d":1620345960000,"h":0.94679,"l":0.94662,"o":0.94669},{"c":0.94663,"d":1620346080000,"h":0.94671,"l":0.94659,"o":0.94665},{"c":0.94649,"d":1620346200000,"h":0.94672,"l":0.94649,"o":0.94663},{"c":0.94645,"d":1620346320000,"h":0.94649,"l":0.94635,"o":0.94649},{"c":0.9466,"d":1620346440000,"h":0.9466,"l":0.94637,"o":0.94645},{"c":0.94649,"d":1620346560000,"h":0.9466,"l":0.94649,"o":0.9466},{"c":0.94633,"d":1620346680000,"h":0.94651,"l":0.94633,"o":0.94649},{"c":0.94615,"d":1620346800000,"h":0.94633,"l":0.94615,"o":0.94633},{"c":0.94618,"d":1620346920000,"h":0.94627,"l":0.9461,"o":0.94615},{"c":0.94616,"d":1620347040000,"h":0.94621,"l":0.94614,"o":0.94618},{"c":0.94615,"d":1620347160000,"h":0.94618,"l":0.94615,"o":0.94616},{"c":0.94609,"d":1620347280000,"h":0.94615,"l":0.94602,"o":0.94615},{"c":0.94622,"d":1620347400000,"h":0.94622,"l":0.94609,"o":0.94609},{"c":0.94621,"d":1620347520000,"h":0.94627,"l":0.94617,"o":0.94622},{"c":0.94611,"d":1620347640000,"h":0.94624,"l":0.94609,"o":0.94621},{"c":0.94617,"d":1620347760000,"h":0.94625,"l":0.94609,"o":0.94611},{"c":0.94617,"d":1620347880000,"h":0.94618,"l":0.94613,"o":0.94617},{"c":0.94615,"d":1620348000000,"h":0.94621,"l":0.94613,"o":0.94617},{"c":0.94615,"d":1620348120000,"h":0.94615,"l":0.9461,"o":0.94615},{"c":0.94623,"d":1620348240000,"h":0.94625,"l":0.9461,"o":0.94615},{"c":0.94635,"d":1620348360000,"h":0.94637,"l":0.94619,"o":0.94623},{"c":0.94641,"d":1620348480000,"h":0.94643,"l":0.94635,"o":0.94635},{"c":0.94639,"d":1620348600000,"h":0.94645,"l":0.94637,"o":0.94641},{"c":0.94618,"d":1620348720000,"h":0.94641,"l":0.94618,"o":0.94639},{"c":0.94597,"d":1620348840000,"h":0.94618,"l":0.94595,"o":0.94618},{"c":0.94596,"d":1620348960000,"h":0.94607,"l":0.94595,"o":0.94597},{"c":0.94597,"d":1620349080000,"h":0.94603,"l":0.94593,"o":0.94596},{"c":0.94601,"d":1620349200000,"h":0.94606,"l":0.94596,"o":0.94597},{"c":0.94603,"d":1620349320000,"h":0.9461,"l":0.946,"o":0.94601},{"c":0.94603,"d":1620349440000,"h":0.94606,"l":0.94597,"o":0.94603},{"c":0.94596,"d":1620349560000,"h":0.94603,"l":0.94585,"o":0.94603},{"c":0.94598,"d":1620349680000,"h":0.94598,"l":0.94586,"o":0.94596},{"c":0.94599,"d":1620349800000,"h":0.94601,"l":0.94591,"o":0.94598},{"c":0.94607,"d":1620349920000,"h":0.94607,"l":0.94597,"o":0.94599},{"c":0.94607,"d":1620350040000,"h":0.94612,"l":0.94601,"o":0.94607},{"c":0.94595,"d":1620350160000,"h":0.94625,"l":0.94593,"o":0.94607},{"c":0.94598,"d":1620350280000,"h":0.94607,"l":0.94595,"o":0.94595},{"c":0.94591,"d":1620350400000,"h":0.94599,"l":0.94589,"o":0.94598},{"c":0.94589,"d":1620350520000,"h":0.94593,"l":0.94585,"o":0.94591},{"c":0.94593,"d":1620350640000,"h":0.94597,"l":0.94589,"o":0.94589},{"c":0.94595,"d":1620350760000,"h":0.94596,"l":0.94589,"o":0.94593},{"c":0.94591,"d":1620350880000,"h":0.94597,"l":0.94589,"o":0.94595},{"c":0.94625,"d":1620351000000,"h":0.94625,"l":0.94583,"o":0.94591},{"c":0.94651,"d":1620351120000,"h":0.94665,"l":0.94625,"o":0.94625},{"c":0.94644,"d":1620351240000,"h":0.94655,"l":0.94631,"o":0.94651},{"c":0.94627,"d":1620351360000,"h":0.94646,"l":0.94627,"o":0.94644},{"c":0.94609,"d":1620351480000,"h":0.94629,"l":0.94609,"o":0.94627},{"c":0.94619,"d":1620351600000,"h":0.94619,"l":0.94607,"o":0.94609},{"c":0.94649,"d":1620351720000,"h":0.94653,"l":0.94615,"o":0.94619},{"c":0.94675,"d":1620351840000,"h":0.94685,"l":0.94649,"o":0.94649},{"c":0.94684,"d":1620351960000,"h":0.9469,"l":0.94675,"o":0.94675},{"c":0.94647,"d":1620352080000,"h":0.94685,"l":0.94635,"o":0.94684},{"c":0.94643,"d":1620352200000,"h":0.94656,"l":0.94639,"o":0.94647},{"c":0.94657,"d":1620352320000,"h":0.94663,"l":0.94638,"o":0.94643},{"c":0.94625,"d":1620352440000,"h":0.94662,"l":0.94623,"o":0.94657},{"c":0.94613,"d":1620352560000,"h":0.94625,"l":0.94605,"o":0.94625},{"c":0.94621,"d":1620352680000,"h":0.94621,"l":0.94608,"o":0.94613},{"c":0.94657,"d":1620352800000,"h":0.94659,"l":0.94617,"o":0.94621},{"c":0.94631,"d":1620352920000,"h":0.94659,"l":0.94631,"o":0.94657},{"c":0.94607,"d":1620353040000,"h":0.94633,"l":0.94603,"o":0.94631},{"c":0.94611,"d":1620353160000,"h":0.94618,"l":0.94602,"o":0.94607},{"c":0.94605,"d":1620353280000,"h":0.94613,"l":0.94597,"o":0.94611},{"c":0.94605,"d":1620353400000,"h":0.94607,"l":0.94597,"o":0.94605},{"c":0.94589,"d":1620353520000,"h":0.94605,"l":0.94583,"o":0.94605},{"c":0.94571,"d":1620353640000,"h":0.94589,"l":0.9457,"o":0.94589},{"c":0.94553,"d":1620353760000,"h":0.94575,"l":0.94546,"o":0.94571},{"c":0.94572,"d":1620353880000,"h":0.94577,"l":0.94551,"o":0.94553},{"c":0.94587,"d":1620354000000,"h":0.94592,"l":0.9457,"o":0.94572},{"c":0.94587,"d":1620354120000,"h":0.94594,"l":0.94578,"o":0.94587},{"c":0.94585,"d":1620354240000,"h":0.94591,"l":0.9458,"o":0.94587},{"c":0.94577,"d":1620354360000,"h":0.94589,"l":0.94577,"o":0.94585},{"c":0.94577,"d":1620354480000,"h":0.94581,"l":0.94573,"o":0.94577},{"c":0.94555,"d":1620354600000,"h":0.94578,"l":0.94553,"o":0.94577},{"c":0.94545,"d":1620354720000,"h":0.94557,"l":0.94539,"o":0.94555},{"c":0.94539,"d":1620354840000,"h":0.94549,"l":0.94527,"o":0.94545},{"c":0.94545,"d":1620354960000,"h":0.94545,"l":0.94532,"o":0.94539},{"c":0.94549,"d":1620355080000,"h":0.94563,"l":0.94541,"o":0.94545},{"c":0.94543,"d":1620355200000,"h":0.94553,"l":0.94539,"o":0.94549},{"c":0.94542,"d":1620355320000,"h":0.94548,"l":0.94539,"o":0.94543},{"c":0.94549,"d":1620355440000,"h":0.94555,"l":0.94542,"o":0.94542},{"c":0.94541,"d":1620355560000,"h":0.94552,"l":0.94541,"o":0.94549},{"c":0.94543,"d":1620355680000,"h":0.94548,"l":0.94535,"o":0.94541},{"c":0.94543,"d":1620355800000,"h":0.94549,"l":0.9454,"o":0.94543},{"c":0.94551,"d":1620355920000,"h":0.94555,"l":0.94543,"o":0.94543},{"c":0.94553,"d":1620356040000,"h":0.9456,"l":0.94551,"o":0.94551},{"c":0.94551,"d":1620356160000,"h":0.94556,"l":0.94547,"o":0.94553},{"c":0.94557,"d":1620356280000,"h":0.94559,"l":0.94551,"o":0.94551}];
// List<Quote> chunkLine = [];
// List<Ohlc> chunkCandle = [];
//
// void iniChunkLine() =>  chunkLine = (chunk1 as List)?.map((e) => Quote.fromJson(e as Map<String, dynamic>))?.toList();
// void iniChunkCandle() => chunkCandle = (chunk2 as List)?.map((e) => Ohlc.fromJson(e as Map<String, dynamic>))?.toList();

//
// Stream<int> quoteStream(int max) async* {
//   Random r = Random();
//   for(var i=0; i <= max; i++) {
//     chunk.add(Quote(
//         d: DateTime.now().add(Duration(milliseconds: r.nextInt(100))), q: 0.90 + (r.nextInt(9).toDouble() / 100)));
//     await Future.delayed(Duration(microseconds: 100));
//     yield i;
//   }
// }

enum TypeChart { Cartesian, Candle }

class Repository extends ChangeNotifier {
  List<Quote> chunkQuote = [];
  List<Ohlc> chunkOhlc = [];
  final Random _rand = Random();
  ChartSeriesController controllerCartesian;
  ChartSeriesController controllerCandle;

  void setControllerCartesian(ChartSeriesController c) => controllerCartesian = c;
  void setControllerCandle(ChartSeriesController c) => controllerCandle = c;

  Repository() {
    // iniChunkLine();
    // iniChunkCandle();
    _iniChunkQuote();
    _iniChunkOhlc();
  }

  void _iniChunkQuote() {
    for (var i = 0; i < 15; i++) {
      addRandQuote();
    }
  }

  void _iniChunkOhlc() {
    for (var i = 0; i < 15; i++) {
      addRandOhls();
    }
  }

  void addRandQuote() {
    // {"d":1620345609863,"q":0.94657}
    DateTime d = chunkQuote.length == 0 ? DateTime.now() : chunkQuote.last.d.add(Duration(seconds: 1));

    chunkQuote.add(Quote(d: d, q: (0.90 + (_rand.nextInt(90).toDouble() / 1000))));
  }

  void addRandOhls() {
    // {"d":1620345600000,"o":0.94661,"h":0.94671,"l":0.94647, "c":0.94659}
    DateTime d = chunkOhlc.length == 0 ? DateTime.now() : chunkOhlc.last.d.add(Duration(seconds: 1));

    double o = (0.94 + ((_rand.nextInt(90).toDouble() - 45.0) / 1000));
    double h = (0.94 + ((_rand.nextInt(90).toDouble() - 45.0) / 1000));
    double l = (0.94 + ((_rand.nextInt(90).toDouble() - 45.0) / 1000));
    double c = (0.94 + ((_rand.nextInt(90).toDouble() - 45.0) / 1000));
    // normalized random values for canle chart
    List<double> ls = [o, h, l, c];
    ls.sort();
    l = ls[0];
    h = ls[3];
    int i = _rand.nextInt(100) % 2;
    int j = (i + 1) % 2;
    o = ls[i + 1];
    c = ls[j + 1];

    chunkOhlc.add(Ohlc(d: d, o: o, h: h, l: l, c: c));
  }

  void addPoint(TypeChart typeChart, ChartSeriesController controller) {
    int len = 0;
    if (typeChart == TypeChart.Cartesian) {
      if (chunkQuote.length > 10) chunkQuote.removeAt(0);
      addRandQuote();
      len = chunkQuote.length;
      controllerCartesian?.updateDataSource(
          addedDataIndexes: <int>[len - 1],
          removedDataIndexes: (len <= 10 ? <int>[] : <int>[0]));
    }
    if (typeChart == TypeChart.Candle) {
      if (chunkOhlc.length > 10) chunkOhlc.removeAt(0);
      addRandQuote();
      len = chunkOhlc.length;
      controllerCandle?.updateDataSource(
          addedDataIndexes: <int>[len - 1],
          removedDataIndexes: (len <= 10 ? <int>[] : <int>[0]));
    }

    //Here accessed the public method of the series.
    notifyListeners();
  }
}
