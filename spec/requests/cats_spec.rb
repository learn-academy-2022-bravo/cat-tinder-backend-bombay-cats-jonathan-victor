require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it"gets a list of all cats" do
    Cat.create(
      name: 'Felix',
      age: 2,
      enjoys: 'Long naps on the couch, and a warm fire.',
      image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
    )
    get"/cats" 
    cat=JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(cat.length).to eq (1)
    end
  end

  describe "POST /create" do
    it "creates a cat" do
      cat_params = {
        cat:   {
          name: 'Homer',
          age: 12,
          enjoys: 'Food mostly, really just food.',
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }
      post"/cats", params:cat_params
      cat = Cat.first
      expect(response).to have_http_status(200)
      expect(cat.name).to eq "Homer"
    end
    it "doesn't create a cat without a name" do
      cat_params = {
        cat: {
          age: 2,
          enjoys: 'Walks in the park',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
    end
    it "doesn't create a cat without a age" do
      cat_params = {
        cat: {
          name: 'Brock',
          enjoys: 'Walks in the park',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['age']).to include "can't be blank"
    end
    it "doesn't create a cat without a enjoys" do
      cat_params = {
        cat: {
          name: 'Brock',
          age: 2,
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['enjoys']).to include "can't be blank"
    end
    it "doesn't create a cat without a image" do
      cat_params = {
        cat: {
          name: 'Brock',
          age: 2,
          enjoys: 'Surfing the sick waves'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['image']).to include "can't be blank"
    end
  end
  
  describe "Patch /update" do
    it"updates one cat" do
      cat_params = {
        cat: {
      name: 'Felix',
      age: 2,
      enjoys: 'Long naps on the couch, and a warm fire.',
      image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }
    post '/cats', params: cat_params
    cat = Cat.first

    update_cat_params = {
      cat: {
      name: 'Felix',
      age: 22,
      enjoys: 'Long naps on the couch, and a warm fire.',
      image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }
    

    patch"/cats/#{cat.id}", params: update_cat_params
    updated_cat = Cat.find(cat.id)
    expect(response).to have_http_status(200)
    expect(updated_cat.age).to eq(22)

    end
  end
  describe "Delete /destroy" do
    it "deletes a cat from the directory" do
      cat_params = {
        cat:   {
          name: 'Homer',
          age: 12,
          enjoys: 'Food mostly, really just food.',
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }
      post"/cats", params:cat_params
      cat = Cat.first

      delete"/cats/#{cat.id}", params: cat_params

      expect(response).to have_http_status(200)

      expect(Cat.find_by(id: cat.id)).to be_nil 
    end
  end
end
