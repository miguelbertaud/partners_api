
# Homie API



[https://quiet-refuge-29239.herokuapp.com/](https://quiet-refuge-29239.herokuapp.com/tenants)



## Install



### Clone the repository



```shell

git clone git@github.com:miguelbertaud/partners_api.git

cd project

```



### Check your Ruby version



```shell

ruby -v

```



The ouput should start with something like `ruby 2.6.5`



If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):



```shell

rbenv install 2.6.5

```



### Install dependencies



Using [Bundler](https://github.com/bundler/bundler)



```shell

bundle install

```



### Restricted Endpoint

To access this endpoint  `/tenants/:tenant_id/properties-published` you need to send an Authorization toke `secret` in your header `HTTP_AUTHORIZATION`





### Initialize the database



```shell

rails db:create db:migrate db:seed

```
 ## Test
```shell

bundle e rspec

```
 ## Endpoints
```shell

rails routes

```
## Serve



```shell

rails s

```

## Filter

```shell

/tenants
#=> acts like a normal request

/tenants?by_name=test
#=> calls the named scope and bring that specific name

```

## Availability

For default all Tenant are available from 8:00AM to 8:00PM
So if you want to set an appointment these are the following steps to created from console
also you can change the interval beetween time availability


```shell
t = Tenant.new
appointments = [["09:00","9:30"],["10:01","11:30"],["14:00","16:30"],["13:01","13:30"]]
t.availability = AvailableTime::TimeSlot.new(8.00,"8.00pm",:interval => 1.hour).free_slots(appointments)
result #=>  [["08:30 AM", "09:00 AM"], ["09:30 AM", "10:00 AM"], ["11:30 AM", "12:00 PM"], ["12:00 PM", "12:30 PM"], ["12:30 PM", "01:00 PM"], ["01:30 PM", "02:00 PM"], ["04:30 PM", "05:00 PM"], ["05:00 PM", "05:30 PM"]]

```

