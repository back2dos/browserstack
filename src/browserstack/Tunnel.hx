package browserstack;

using tink.CoreApi;

import js.Error;
import js.Node;
import js.node.ChildProcess;

typedef TunnelOptions = {
  key: String,
  ?hosts: Array<{
    name: String,
    port: Int,
    sslFlag: Bool
  }>,// optionally set hosts 
  ?osxBin: String, // optionally override the default bin directory for the OSX binary 
  ?linux32Bin: String, // optionally override the default bin directory for the Linux 32 bit binary 
  ?linux64Bin: String, // optionally override the default bin directory for the Linux 64 bit binary 
  ?win32Bin: String, // optionally override the default bin directory for the win32 binary 
  ?localIdentifier: String, // optionally set the -localIdentifier option 
  ?v: Bool, // optionally set the -v (verbose) option 
  ?proxyUser: String, // optionally set the -proxyUser option 
  ?proxyPass: String, // optionally set the -proxyPass option 
  ?proxyPort: Int, // optionally set the -proxyPort option 
  ?proxyHost: String, // optionally set the -proxyHost option 
  ?force: Bool, // optionally set the -force option 
  ?forcelocal: Bool, // optionally set the -forcelocal option 
  ?onlyAutomate: Bool, // optionally set the -onlyAutomate option 
  
}

@:jsRequire('browserstacktunnel-wrapper') extern class Tunnel { 
  
  function new(options:TunnelOptions):Void;
  function start(?e:Error->Void):Void;
  function stop(e:Error->Void):Void;
  
  public inline function run<A>(f:Void->Future<A>):Surprise<A, Error>
    return 
      Future.async(function (cb) 
        this.start(function (e) {
          trace('Tunnel started');
          if (e != null) 
            cb(Failure(e))
          else
            f().handle(function (ret) 
              this.stop(function (e) {
                if (e != null)
                  cb(Failure(e));
                else {
                  cb(Success(ret));
                  trace('Tunnel stopped'); 
                }
              })
            );
        })
      );
}