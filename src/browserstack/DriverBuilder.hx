package browserstack;
import webdriver.WebDriver;

@:jsRequire('browserstack-webdriver', 'Builder')
extern class DriverBuilder {

  function new():Void;
  function usingServer(url:String):DriverBuilder;
  function withCapabilities(capabilities:NativeCapabilities):DriverBuilder;
  function setProxy(config:Dynamic):DriverBuilder;
  function build():WebDriver;
  
}

abstract NativeCapabilities(Dynamic) {

  inline function new(v) 
    this = v; 
  
  @:from static function fromHx(c:Capabilities)
    return new NativeCapabilities({
      browserName: c.browserName,
      'browserstack.user': c.browserstack.user,
      'browserstack.key': c.browserstack.key,
      'browserstack.local' : if (c.browserstack.local) 'true' else 'false',
    });
}