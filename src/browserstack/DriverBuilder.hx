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
  
  @:from static function fromHx(c:Capabilities){
    var mapped = Reflect.copy(c);
    Reflect.setField(mapped, 'browserstack.user', mapped.browserstack.user);
    Reflect.setField(mapped, 'browserstack.key', mapped.browserstack.key);
    Reflect.setField(mapped, 'browserstack.local', mapped.browserstack.local);
    Reflect.deleteField(mapped, 'browserstack');
    return new NativeCapabilities(mapped);
  }
}
