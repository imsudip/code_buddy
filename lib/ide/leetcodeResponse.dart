// To parse this JSON data, do
//
//     final compileResponse = compileResponseFromJson(jsonString);

import 'dart:convert';

CompileResponse compileResponseFromJson(String str) =>
    CompileResponse.fromJson(json.decode(str));

String compileResponseToJson(CompileResponse data) =>
    json.encode(data.toJson());

class CompileResponse {
  CompileResponse({
    this.codeOutput,
    this.elapsedTime,
    this.lang,
    this.memory,
    this.prettyLang,
    this.runSuccess,
    this.state,
    this.statusCode,
    this.statusMemory,
    this.statusMsg,
    this.statusRuntime,
    this.submissionId,
    this.taskFinishTime,
  });

  List<String> codeOutput;
  int elapsedTime;
  String lang;
  int memory;
  String prettyLang;
  bool runSuccess;
  String state;
  int statusCode;
  String statusMemory;
  String statusMsg;
  String statusRuntime;
  String submissionId;
  int taskFinishTime;

  factory CompileResponse.fromJson(Map<String, dynamic> json) =>
      CompileResponse(
        codeOutput: List<String>.from(json["code_output"].map((x) => x)),
        elapsedTime: json["elapsed_time"],
        lang: json["lang"],
        memory: json["memory"],
        prettyLang: json["pretty_lang"],
        runSuccess: json["run_success"],
        state: json["state"],
        statusCode: json["status_code"],
        statusMemory: json["status_memory"],
        statusMsg: json["status_msg"],
        statusRuntime: json["status_runtime"],
        submissionId: json["submission_id"],
        taskFinishTime: json["task_finish_time"],
      );

  Map<String, dynamic> toJson() => {
        "code_output": List<dynamic>.from(codeOutput.map((x) => x)),
        "elapsed_time": elapsedTime,
        "lang": lang,
        "memory": memory,
        "pretty_lang": prettyLang,
        "run_success": runSuccess,
        "state": state,
        "status_code": statusCode,
        "status_memory": statusMemory,
        "status_msg": statusMsg,
        "status_runtime": statusRuntime,
        "submission_id": submissionId,
        "task_finish_time": taskFinishTime,
      };
}
