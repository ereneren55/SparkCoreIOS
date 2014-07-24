Spark Core iOS Library
=====================
This project will create a very simple Objective-C library that can be used to communicate with the Spark Core API service.  Currently the library is working but I would like to add more bells and whistles as well as more error checking.  

Update 1  -  Rewrote the library today to make it easier to use for applications that need multiple requests.  

I will be writing a post in my blog over the next two days detailing how this library works.  I will post a link here when it is complete.  


---------------
## Spark Transactions

Here is the list of the initiators that come with the library

*  SparkTransactionGet - Used to create a GET request to the Spark API
*  SparkTransactionPost - Used to create a POST request to the Spark API

---------------
## Methods

Here is the one method that is currently implemented

*  -(void)connectToSparkAPIWithTransaction:andHandler: - Sends the transaction to the Spark API

---------------
## Installation

You will need to copy the following files to your project:
  - SparkTransaction.h
  - SparkTransaction.m
  - SparkTransactionGet.h
  - SparkTransactionGet.m
  - SparkTransactionPost.h
  - SparkTransactionPost.m
  - SparkCoreConnector.h
  - SparkCoreConnector.m

---------------
## Sample

The sample project turns the user led on/off as you press the button.  To try the sample, you will need to begin by flashing the following code to your Spark Core:

```
int ledUser = D7;
int led1 = D0;
int led2 = D5;
int myvar = 0;

void setup() {
    Spark.function("led", ledController);
    
    pinMode(ledUser, OUTPUT);
    pinMode(led1, OUTPUT);
    pinMode(led2, OUTPUT);
    
    digitalWrite(ledUser, LOW);
    digitalWrite(led1, LOW);
    digitalWrite(led2, LOW);
    
    Spark.variable("myvar", &myvar, INT);
}

void loop() {
    
}

int ledController(String command) 
{
    myvar = myvar +1;
    int ledState = 0;
    int pinNumber = (command.charAt(1) - '0');
    
    if (pinNumber != 0 && pinNumber != 5 && pinNumber !=7) {
        return -1;
    }
    
    if(command.substring(3,7) == "HIGH") ledState = HIGH;
   else if(command.substring(3,6) == "LOW") ledState = LOW;
   else return -2;
    
    digitalWrite(pinNumber,ledState);
    
    return 1;
}
```

You will need to change the accessToken and deviceID in the ViewController.m file.  Look for this line:

SparkCoreConnector *spark = [[SparkCoreConnector alloc]initWithAccessToken:@"0123456789abcdef" deviceId:@"myid" functionName:@"tester" andParameters:@"test param"];

and update the accessToken and deviceId to match your Spark Core.
