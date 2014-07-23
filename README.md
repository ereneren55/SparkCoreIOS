Spark Core iOS Library
=====================
This project will create a very simple Objective-C library that can be used to communicate with the Spark Core API service.  Currently the library is working but I would like to add more bells and whistles as well as more error checking.

---------------
## Initiators

Here is the list of the initiators that come with the library

*  -(instancetype)init  - Default initiator that sets all properties to the default value
*  -(instancetype)initWithAccessToken:andDeviceId:  - Initiator that sets everything to default using the default init method then sets the accessToken and deviceId properties
*  -(instancetype)initWithAccessToken:token deviceId:andFunctionName: - initiator that uses the initWithAccessToken:andDeviceId: Initiator and then sets the functionName property
*  -(instancetype)initWithAccessToken:token deviceId:functionName:andParameters: -  Initiator that uses the initWithAccessToken:deviceId:andFunctionName: initiator and then sets the parameters property

---------------
## Methods

Here is the one method that is currently implemented

*  -(void)connectWithCompletionHandler: - Connects and sends the POST request to the Spark API

---------------
## Installation

Since the library is only one class, I would recommend simply coping the header and implementation to your project.  Once the project begins to grow I will probably change this.

---------------
## Sample

The sample project turns the user led on/off as you press the button.  To try the sample, you will need to begin by flashing the following code to your Spark Core:

```
int userLed = D7;
int ledStatus = 0;

void setup()
{
	Spark.function("tester", testerControl);
	pinMode(userLed, OUTPUT);
}

void loop()
{
	//doing nothing
}

int testerControl(String command)
{
    if (ledStatus == 0) 
	{
		digitalWrite(userLed, HIGH);
		ledStatus = 1;
		return 1;
	}
    if (ledStatus == 1)
    {
        digitalWrite(userLed, LOW);
        ledStatus = 0;
        return 1;
    }   
    ledStatus = 0;
    return -1;
}
```

You will need to change the accessToken and deviceID in the ViewController.m file.  Look for this line:

SparkCoreConnector *spark = [[SparkCoreConnector alloc]initWithAccessToken:@"0123456789abcdef" deviceId:@"myid" functionName:@"tester" andParameters:@"test param"];

and update the accessToken and deviceId to match your Spark Core.
