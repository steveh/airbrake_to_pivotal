Deprecated
==========

Airbrake now natively supports Pivotal Tracker, but not for Heroku users.

http://help.airbrake.io/kb/integrations/pivotal-tracker-integration

Heroku Users
============
To get it working with Heroku, the integration is a two step process.

* Adding exceptions as "bug" stories in Pivotal Tracker
 * Use the [instructions](#instruction) below (not those from the link above)
* Getting updates from Pivotal Tracker in your Airbrake errors
 * Follow the instructions from the [link](http://help.airbrake.io/kb/integrations/pivotal-tracker-integration) above.

***

Instructions
============

1. Grab a copy of the source

        git clone git://github.com/steveh/airbrake_to_pivotal.git

2. Create a Heroku app

        heroku create myapp

3. Your airbrake username is from eg http://acme.airbrakeapp.com/

        heroku config:add AIRBRAKE_USERNAME=acme

4. This is your user auth token, not the project auth token, which doesn't work. From eg http://acme.airbrakeapp.com/users/12345/edit

        heroku config:add AIRBRAKE_AUTH_TOKEN=3d1040234ed4c1340293c58db80b27b559473c81

5. You can leave the requestor blank, if you like.

        heroku config:add AIRBRAKE_REQUESTOR="John Smith"

6. Your project ID is from eg http://acme.airbrakeapp.com/projects/12345/errors

        heroku config:add AIRBRAKE_PROJECT_ID=12345

7. Pick a username for Pivotal to use

        heroku config:add HTTP_BASIC_USERNAME=pivotal

8. Pick a password for Pivotal to use

        heroku config:add HTTP_BASIC_PASSWORD=password

9. Deploy to Heroku

        git push heroku master

10. Test you're getting XML back

        open http://myapp.heroku.com/

11. Add the integration to Pivotal. From the "Configure Integrations" page, add an "Other" integration.

    * **Name:** Airbrake
    * **Basic Auth username:** What you picked for HTTP_BASIC_USERNAME
    * **Basic Auth password:** What you picked for HTTP_BASIC_PASSWORD
    * **Base URL:** http://acme.airbrakeapp.com/errors/
    * **Import API URL:** http://myapp.heroku.com/
    * **Active: Yes**

12. From the "More" menu of Pivotal Tracker you should see "Airbrake"
