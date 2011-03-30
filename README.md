1. Grab a copy of the source

    git clone git://github.com/steveh/hoptoad_to_pivotal.git

2. Create a Heroku app

    heroku create myapp --stack bamboo-mri-1.9.2

3. Your hoptoad username is from eg http://acme.hoptoadapp.com/

    heroku config:add HOPTOAD_USERNAME=acme

4. This is your user auth token, not the project auth token, which doesn't work. From eg http://acme.hoptoadapp.com/users/12345/edit

    heroku config:add HOPTOAD_AUTH_TOKEN=deadbeef

5. You can leave the requestor blank, if you like.

    heroku config:add HOPTOAD_REQUESTOR="John Smith"

6. Your project ID is from eg http://acme.hoptoadapp.com/projects/12345/errors

    heroku config:add HOPTOAD_PROJECT_ID=12345

7. Pick a username for Pivotal to use

    heroku config:add HTTP_BASIC_USERNAME=pivotal

8. Pick a password for Pivotal to use

    heroku config:add HTTP_BASIC_PASSWORD=password

9. Deploy to Heroku

    git push heroku master

10. Test you're getting XML back

    open http://myapp.heroku.com/

11. Add the integration to Pivotal. From the "Configure Integrations" page, add an "Other" integration.

    Name: Hoptoad
    Basic Auth username: What you picked for HTTP_BASIC_USERNAME
    Basic Auth password: What you picked for HTTP_BASIC_PASSWORD
    Base URL: http://acme.hoptoadapp.com/errors/
    Import API URL: http://myapp.heroku.com/
    Active: Yes

12. From the "More" menu of Pivotal Tracker you should see "Hoptoad"

13. Buy me a beer.