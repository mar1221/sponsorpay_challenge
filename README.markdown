# SponsorPay challenge README

[Working demo](http://dry-dawn-9575.herokuapp.com/ "Sponsorpay challenge demo")

## Ruby and Rails versions

* Ruby version - 2.1.1

* Rails version - 4.0.4

## Tests

Tests are written in RSpec: `$ bundle exec rspec spec/ -fd`

## Configuration

OffersApiService communicating with SponsorPay offers API can be configured
in `config/service_config.yml`

## Others

Application is running without a DB

## Few thoughts about implementation

I was aiming to provide a complete working example and to use some of the
technologies mentioned in the job description. At the same time I did not
want the application to get too complex and therefore I have made some design
decisions I would not normally do. For example I have decided not to test
client side code (with exception of integration tests). Here I go into the
details of the implementation and the issues I've ran into.

### Ruby on Rails

Quite standard server side application. I didn't need database so I removed
active record but I still used active model for modeling Request object (could
be useful if I would want to, for example, log requests in the future). Main
parts of the application are Request model, OffersApiService object and Offers
controller.

#### Request model

Tableless model. Is in charge of validations. Could be useful if the connection
to the database would be needed at some point in the future.

#### OffersApiService object

Service object responsible for issuing requests to the API and verifying it's
responses. Although I know service objects are not exactly the Rails Way I
like to use them in the cases like this one. I think they are closer to OO
design and can make things a little cleaner. Especially in the case when the
application has to communicate with an external service. It just seems right
to extract the functionality out of the model.

I decided not to test it's private methods only because I believe that
testing the outcomes of the initialization and public method `get_offers`
it's more than enough to catch and locate possible bugs.

I also tried to demonstrate three different ways of attributes initialization.
First one, parameter passing is clear and according to the assignment.
The configuration file `/config/service_config.yml` is in my opinion the way
to go. Normally I would put it to the .gitignore file and create an example
version. First reason to do so is security: I don't want an API key to be under
the source control. Second one is that it makes modifications of the service
object easier. If one of the configuration attributes changes I don't need
to make changes to the service object itself. I can just edit the configuration
file. I also used some hard-coded values - these are probably good enough for
prototype but I wouldn't use them in a production app.

I left exceptions declarations and the service class itself in the same file.
If the class would grow any larger I would probably extract them to a separate
file.

#### Offers controller

Standard Rails controller. Index renders the template (html) and process the
json requests to load offers.

### Angular JS

To be honest I have used Angular mainly because there were promised some bonus
points for knowledge of a JS framework. This setup seems kind of strange
to me. Normally I would recommend to either use angular directly and communicate
with the API from client or not to use it at all and let Rails do the work.
My main objection is that in this way the communications are doubled (client ->
server -> API -> server -> client). On the other hand I can imagine similar
setup if one would need to let the server do the heavy lifting and process
the response from API and then just send the result to the client.

I choose not to test angular code. I needed to finish the application in some
reasonable time and did not want to go into the trouble. Also in the end
I have decided to write rspec feature tests which should catch most of the
client side errors.

### Testing

I picked RSpec. I have the most experience with it. Minitest is fine as well.
The true question was: To stub or not to stub? :). The approach I use in my
applications is to stub all the tests but integration (end-to-end tests).
The reason for this is simple: I want my tests to run fast and I want
to avoid external dependencies like internet connectivity or service unavailability.
But... according to the assignment I should write only unit and functional
tests. Therefore I had decided not to stub and let them send requests to the
SponsorPay API. The rather small test suite started to be really slow and
I couldn't sleep calmly because of that so in the end I have written end-to-end
tests as well and stubbed any other tests in the application.
BTW the reason I do not want to stub the integration tests is that I like
them to be as close to actual user's behaviour as possible.

### Validations

I choose to use Rails built in validators and to send possible validation
errors to the angular client in the json format. Very nice on this solution
is that the validations are declared on one place. On the other hand every
time the form is validated there is an unnecessary trip to the server.

The alternative approach would be to either introduce angular JS client side
form validations (but here we would have validations declared on two places
- which can but do not have to be bad) or to come up with a way how to send
the validation rules to the client with the initial page load.

### Foundation

Only to improve UX.
