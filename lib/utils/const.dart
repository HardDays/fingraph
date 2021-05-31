//
// Contains all application constants
//
const String kTitle = 'Syncfusion Flutter chart';

// for WebSocketApi
const String kWsToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlYXQiOjE4OTQzMTY0MDAsInVzZXJfaWQiOjF9.j-V2lLG-vyDQNdlG_ya7jT9hOjPbqcVivd8rwRqxqho';
const String kWsUrl = 'wss://staging.finrooms.com/ws/quotes';
const String kWsUrlDoc = 'https://staging.finrooms.com/ms/user/assets/available';

const String kWsExampleFirstQuery = '{"jsonrpc":"2.0","method":"subscribe","params":[{"channels":["tick.aud_usd_afx"]}]}';

const String kWsMethodTick = 'q';
const String kWsMethodOhlc = 'o';


const int kMaxLenData = 5000;

// wss://staging.finrooms.com/ws/quotes?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlYXQiOjE4OTQzMTY0MDAsInVzZXJfaWQiOjF9.j-V2lLG-vyDQNdlG_ya7jT9hOjPbqcVivd8rwRqxqho
// {"jsonrpc":"2.0","method":"subscribe","params":[{"channels":["tick.aud_usd_afx"]}]}

// response:
// {"jsonrpc":"2.0","method":"q","params":{"i":56, "d":1622444215131, "q":0.77269}}
