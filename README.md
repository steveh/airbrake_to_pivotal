1. Grab a copy of the source

        git clone git://github.com/steveh/airbrake_to_pivotal.git

2. Create a Heroku app

        heroku create myapp --stack bamboo-mri-1.9.2

3. Your airbrake username is from eg http://acme.airbrakeapp.com/

        heroku config:add AIRBRAKE_USERNAME=acme

4. This is your user auth token, not the project auth token, which doesn't work. From eg http://acme.airbrakeapp.com/users/12345/edit

        heroku config:add AIRBRAKE_AUTH_TOKEN=deadbeef

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

13. Buy me a beer.
