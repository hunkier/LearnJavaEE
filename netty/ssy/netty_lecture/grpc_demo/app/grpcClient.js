var PROTO_FILE_PATH = 'G:\\Users\\hunk\\IdeaProjects\\LearnNote\\netty\\ssy\\netty_lecture\\src\\main\\proto\\Student.proto';
var grpc =  require('grpc');
var grpcService = grpc.load(PROTO_FILE_PATH).com.hunk.proto;

var client = new grpcService.StudentService('localhost:8899', grpc.credentials.createInsecure());

client.getRealNameByUsername({username: 'zhangsan'}, function (error, respData) {
    console.log(respData);
})