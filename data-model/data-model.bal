// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/time;
import ballerina/sql;

public type User_idel record {|
    readonly string user_id;
    string username;
    string fullname;
    string role;
    Organization[] organizations;   
    Contestant[] contestants;       
    Moderator[] moderators;         
    Challenge_Ideal[]  authoredChallenges;        
|};

public type User record {|
    readonly string user_id;
    string username;
    string fullname;
    string role;
|};

public type Organization record {|
    readonly string org_id;
    string name;
    string category;
    User[] members;       
    Contest_Ideal[] contests;     
    Challenge[]  poolOfChallenges;        
|};

public type Moderator record {|
    readonly moderator_id;
    User user;
    Contest_Ideal contest;        
|};

public type Contest_Ideal record {|
    readonly string contest_id;
    Organization organization;      
    string name;
    time:Date start_time;
    time:Date end_time;
    Challenge_Ideal[] challenges;     
    Moderator[] moderators;     
    Contestant[] contestants;     
|};

public type Contestant record {|
    readonly User user;
    readonly Contest_Ideal contest;       
    decimal total_score;
|};

public enum Challenge_Type {
    PUBLIC,
    PRIVATE
}


public type Challenge_Ideal record {|
    readonly string challenge_id;
    string name;
    Challenge_Type type_of_challenge;
    User author;        
    Organization owner;     
    string editorial;
    string problem_description;
    Environment environment;        
    TestCase[] testcases;       
    Submission[] submissions;       
    Contest_Ideal[] contests;    
|};

public type Submission record {|
    readonly string submission_id;
    string input;
    decimal score;
    time:Date submitted_time;
    Challenge_Ideal challenge;                  
    Contestant contestant;      
|};

public type TestCase record {|
    readonly string testcase_id;
    Challenge_Ideal challenge;        
    string input;
    string expected_output;
    decimal weight;
|};

public type Environment record {|
    readonly environtment_id;
    string name;
    string description;
    string stored_url;
    Challenge_Ideal[] challenges;     
|};

public const QUEUE_NAME = "RequestQueue";
public const EXEC_TO_SCORE_QUEUE_NAME = "ExecToScoreQueue";

public type SubmissionMessage record {
    string userId;
    string contestId;
    string challengeId;
    string fileName;
    string fileExtension;
    string submissionId;
};

public type ScoredSubmissionMessage record {|
    SubmissionMessage subMsg;
    float score;
|};

public type Challenge record{
    @sql:Column {name: "challenge_id"}
    string challengeId;
    string title;
    byte[] readme;
    string difficulty;
    byte[] testCase;
    @sql:Column {name: "challenge_template"}
    byte[]? template;
    string authorId;
};

public type Contest record {
    @sql:Column {name: "contest_id"}
    string contestId;
    string title;
    byte[] readme;
    @sql:Column {name: "start_time"}
    time:Civil startTime;
    @sql:Column {name: "end_time"}
    time:Civil endTime;
    string moderator;
};