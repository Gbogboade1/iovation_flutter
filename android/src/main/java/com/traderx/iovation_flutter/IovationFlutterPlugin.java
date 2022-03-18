package com.traderx.iovation_flutter;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.iovation.mobile.android.FraudForceConfiguration;
import com.iovation.mobile.android.FraudForceManager;

import java.util.concurrent.Future;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** IovationFlutterPlugin */
public class IovationFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  private Activity activity;
  private  FraudForceManager fraudForceManager;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "iovation_flutter");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("initializeIovation")) {
        String subscriberKey = call.argument("subscriberKey");

    final boolean isDone =    initializeIovation(subscriberKey);
      result.success(isDone);
    } else if (call.method.equals("getBlackBoxString")) {
        final String  blackBox=    getBlackBoxString();
        result.success(blackBox);
    }{
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

 boolean initializeIovation(String subscriberKey) {
      try {
          FraudForceConfiguration fraudForceConfiguration = new FraudForceConfiguration.Builder()
                  .enableNetworkCalls(true)
                  .subscriberKey(subscriberKey)
                  .build();

          fraudForceManager = FraudForceManager.getInstance();

          fraudForceManager.initialize(fraudForceConfiguration, context);
          return false;
      }catch (Exception e){
          return false;
      }

  }

  String getBlackBoxString(){
      try {
          final String blackBoxString =  FraudForceManager.getInstance().getBlackbox(context);
          return  blackBoxString;
      }catch (Exception e){
          return "Error";
      }

  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }
}
