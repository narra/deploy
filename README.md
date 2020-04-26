![narra logo](https://github.com/narra/platform/raw/master/narra.png)

Deployment
==========  

### Development and Debug

To deploy in dev mode (requirements are docker and docker-compose and you have to free ports 80). You have to have narra repository clonned side by side with narra-deploy repo. For module development remains the same. It should be side by side with the narra-deploy and narra repo. Then in narra gemifile it should be added relatively like ```gem 'you_gem', path: '../your_gem'```.

    make start

Then NARRA API Service will be available on [http://api.narra](http://api.narra), NARRA Editor Service will be available on [http://editor.narra](http://editor.narra) and NARRA Storage Service will be available on [http://storage.narra](http://storage.narra).

To debug master or worker node just call

    make debug
    
Then for master node debugger will run on port ```1234``` and for worker node on port ```1235```. Debug mode is prepared for RubyMine Remote Debugging.

### Environment variables

All environment variables essential for deploy are located in ```narra.env``` file.

#### `NARRA_INSTANCE_NAME`

Site unique instance name. It should be unique for the same storage account.

#### `AWS_ACCESS_KEY`, `AWS_SECRET`, `AWS_REGION`, `AWS_BUCKET`  optional

Amazon AWS Access Credentials for storage type ```aws```. When enabled the ```aws``` storage is activated.

#### `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET` optional

GitHub user authentication service

#### `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` optional

Google user authentication service
