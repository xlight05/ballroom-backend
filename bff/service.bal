import ballerina/http;
import ballerina/log;

configurable string contestServiceUrl = ?;
configurable string challengeServiceUrl = ?;
configurable string uploadServiceUrl = ?;
configurable string userServiceUrl = ?;
configurable string submissionServiceUrl = ?;

@display {
    label: "BFF for Ballroom Webapp",
    id: "BFFBallroomWebapp"
}
@http:ServiceConfig {
    cors: {
        allowOrigins: ["https://localhost:3000"],
        allowCredentials: true,
        allowHeaders: ["CORELATION_ID", "Authorization", "Content-Type", "authorization", "ngrok-skip-browser-warning"],
        exposeHeaders: ["X-CUSTOM-HEADER"],
        maxAge: 84900
    }
}
service / on new http:Listener(9099) {
    @display {
        label: "Contest Service",
        id: "ContestService"
    }
    private final http:Client contestService;

    @display {
        label: "Challenge Service",
        id: "ChallengeService"
    }
    private final http:Client challengeService;

    @display {
        label: "Upload Service",
        id: "UploadService"
    }
    private final http:Client uploadService;

    @display {
        label: "User Service",
        id: "UserService"
    }
    private final http:Client userService;

    @display {
        label: "Submission Service",
        id: "SubmissionService"
    }
    private final http:Client submissionService;

    function init() returns error? {
        self.contestService = check new (contestServiceUrl);
        self.challengeService = check new (challengeServiceUrl);
        self.uploadService = check new (uploadServiceUrl);
        self.userService = check new (userServiceUrl);
        self.submissionService = check new (submissionServiceUrl);
        log:printInfo("BFF service started...");
    }

    resource function 'default challengeService/[string... paths](http:Request req) returns http:Response|error {
        return check self.challengeService->forward(req.rawPath, req);
    }

    resource function 'default contestService/[string... paths](http:Request req) returns http:Response|error {
        return check self.contestService->forward(req.rawPath, req);
    }

    resource function 'default uploadService/[string... paths](http:Request req) returns http:Response|error {
        return check self.uploadService->forward(req.rawPath, req);
    }

    resource function 'default userService/[string... paths](http:Request req) returns http:Response|error {
        return check self.userService->forward(req.rawPath, req);
    }

    resource function 'default submissionService/[string... paths](http:Request req) returns http:Response|error {
        return check self.submissionService->forward(req.rawPath, req);
    }
}

