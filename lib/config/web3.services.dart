import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:renderscan/utils/logger.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class Note {
  final int id;
  final String title;
  final String descrpition;

  Note({required this.id, required this.title, required this.descrpition});
}

class Web3Servives extends ChangeNotifier {
  List<Note> notes = [];
  final String _rpcUrl =
      Platform.isAndroid ? "http://10.0.2.2:7545" : "http://127.0.0.1:7545";
  final String _wsUrl =
      Platform.isAndroid ? "ws://10.0.2.2:7545" : "ws://127.0.0.1:7545";
  bool isLoading = true;

  // use walletconnect_dart for this in web3 flutter
  // learn latter
  final String _privateKey =
      "b8949e97f55cc15476273e6379e27a1cb1f81c7ab354763f5d815438d09dd109";

  late Web3Client _web3client;
  late EthereumAddress _contractAddress;
  late ContractAbi _contractAbi;
  late EthPrivateKey _ethPrivateKey;
  late DeployedContract _deployedContract;
  late ContractFunction _createNote;
  // late ContractFunction _deleteNote;
  late ContractFunction _notes;
  late ContractFunction _notesCount;

  Future<void> getCreds() async {
    _ethPrivateKey = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _deployedContract = DeployedContract(_contractAbi, _contractAddress);
    _createNote = _deployedContract.function("createNote");
    // _deleteNote = _deployedContract.function("createNote");
    _notes = _deployedContract.function("notes");
    _notesCount = _deployedContract.function("noteCount");
    await fetchNotes();
  }

  Future<void> createNote(String title, String description) async {
    await _web3client.sendTransaction(
        _ethPrivateKey,
        Transaction.callContract(
            contract: _deployedContract,
            function: _createNote,
            parameters: [title, description]));
    isLoading = true;
    notifyListeners();
    fetchNotes();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getABI() async {
    String abiFile =
        await rootBundle.loadString('assets/contracts/NotesContract.json');
    var abi = jsonDecode(abiFile);
    _contractAbi =
        ContractAbi.fromJson(jsonEncode(abi['abi']), "NotesContract");
    _contractAddress =
        EthereumAddress.fromHex(abi["networks"]["5777"]["address"]);
  }

  Future<void> init() async {
    _web3client = Web3Client(_rpcUrl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getABI();
    await getCreds();
    await getDeployedContract();
    log.i("contracts loaded");
  }

  Future<void> fetchNotes() async {
    List totalTaskList = await _web3client.call(
      contract: _deployedContract,
      function: _notesCount,
      params: [],
    );

    int totalTaskLen = totalTaskList[0].toInt();
    notes.clear();
    for (var i = 0; i < totalTaskLen; i++) {
      var temp = await _web3client.call(
          contract: _deployedContract,
          function: _notes,
          params: [BigInt.from(i)]);
      if (temp[1] != "") {
        notes.add(
          Note(
            id: (temp[0] as BigInt).toInt(),
            title: temp[1],
            descrpition: temp[2],
          ),
        );
      }
    }

    notifyListeners();
  }

  NotesServices() {
    init();
  }
}
