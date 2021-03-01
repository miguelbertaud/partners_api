
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
