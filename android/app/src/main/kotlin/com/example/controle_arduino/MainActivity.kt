package com.example.controle_arduino

import android.bluetooth.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {

    private val CHANNEL = "bluetooth"
    private var socket: BluetoothSocket? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                when (call.method) {

                    "list" -> {
                        result.success(listarDispositivos())
                    }

                    "connect" -> {
                        val mac = call.argument<String>("mac")
                        conectar(mac!!)
                        result.success(null)
                    }

                    "send" -> {
                        val data = call.argument<String>("data")
                        enviar(data!!)
                        result.success(null)
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun listarDispositivos(): List<Map<String, String>> {
        val adapter = BluetoothAdapter.getDefaultAdapter()
        val devices = adapter.bondedDevices

        val lista = mutableListOf<Map<String, String>>()

        for (device in devices) {
            val item = mapOf(
                "name" to (device.name ?: "Sem nome"),
                "address" to device.address
            )
            lista.add(item)
        }

        return lista
    }

    private fun conectar(mac: String) {
        val adapter = BluetoothAdapter.getDefaultAdapter()
        val device = adapter.getRemoteDevice(mac)

        val uuid = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")

        socket = device.createRfcommSocketToServiceRecord(uuid)
        socket?.connect()
    }

    private fun enviar(data: String) {
        socket?.outputStream?.write(data.toByteArray())
    }
}