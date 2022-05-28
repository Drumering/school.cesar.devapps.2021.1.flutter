package school.cesar.ama.wifi_plugin

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** WifiPlugin */
class WifiPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var connectivityManager: ConnectivityManager

  @RequiresApi(Build.VERSION_CODES.M)
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wifi_plugin")
    context = flutterPluginBinding.applicationContext
    connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    listenConnectivity()
    channel.setMethodCallHandler(this)
  }

  @RequiresApi(Build.VERSION_CODES.M)
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) =
    when (call.method) {
        "getPlatformVersion" -> {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        "getWifiStatus" -> {
          result.success(hasConnectivity())
        }
        else -> {
          result.notImplemented()
        }
    }

  @RequiresApi(Build.VERSION_CODES.M)
  fun hasConnectivity(): Boolean {
    val activeNetwork = connectivityManager.activeNetwork
    val networkCapabilities = connectivityManager.getNetworkCapabilities(activeNetwork)
    return networkCapabilities != null && networkCapabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
  }

  @RequiresApi(Build.VERSION_CODES.M)
  fun listenConnectivity(){
    val request = NetworkRequest.Builder().addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET).build()
    connectivityManager.registerNetworkCallback(request, object: ConnectivityManager.NetworkCallback(){

      override fun onLost(network: Network) {
        super.onLost(network)
        Handler(Looper.getMainLooper()).post{
          channel.invokeMethod("onConnectivityChanged", false)
        }
      }

      override fun onAvailable(network: Network) {
        super.onAvailable(network)
        Handler(Looper.getMainLooper()).post{
          channel.invokeMethod("onConnectivityChanged", true)
        }
      }
    })
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
