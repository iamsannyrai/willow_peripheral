import 'esp/sec0.pb.dart';
import 'esp/session.pb.dart';

class Security0 {
  int _step = 0;

  List<int>? securityRequest(List<int>? resp) {
    switch (_step) {
      case 0:
        _step++;
        return _setupRequest();
      case 1:
      default:
        return null;
    }
  }

  List<int> _setupRequest() {
    var setupReq = SessionData(
      secVer: SecSchemeVersion.SecScheme0,
      sec0: Sec0Payload(
        msg: Sec0MsgType.S0_Session_Command,
        sc: S0SessionCmd(),
      ),
    );

    return setupReq.writeToBuffer();
  }
}
