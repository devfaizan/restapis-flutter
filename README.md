# restapis-flutter

An android that uses Laravel as backend. This app provides simple create, update & delete functions, where you can add new users, edit their name & delete them forever. This app doesn't provide any authentication mechanism. 

## Deep Dive

Firstly app intiailize by displaying splash screen and checks if connection is made to the server, if not then it displays an error screen, else app will redirect you to home screen from where you can add new users through a validated form.

Next up we have user screen where app displays list of added users. In listtile we have username, useremail & icons from where you can edit username & delete button that deletes user.

At bottom for every screen there is a bottomnavbar through which you can navigate to different pages. State of this bottomnavbar is managed through Provider.

User data travels within app using models & data is requested from server through http requests.

