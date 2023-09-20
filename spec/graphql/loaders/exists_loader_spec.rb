# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loaders::ExistsLoader do
  describe "#load" do
    let(:today) { Time.zone.today }
    let!(:user) { User.create!(name: "test") }
    let!(:has_book_user) {
      User.create!(name: "test", books: [
        Book.new(name: "book1", purchase_on: today), Book.new(name: "book2", purchase_on: today)
      ])
    }

    context "has no condition" do
      context "user does not has book" do
        it {
          result = GraphQL::Batch.batch do
            Loaders::ExistsLoader.for(Book, :user_id).load(user.id)
          end
          expect(result).to eq false
        }
      end

      context "user has books" do
        it {
          result = GraphQL::Batch.batch do
            Loaders::ExistsLoader.for(Book, :user_id).load(has_book_user.id)
          end
          expect(result).to eq true
        }
      end
    end

    context "has conditions" do
      context "name is not match" do
        it {
          result = GraphQL::Batch.batch do
            Loaders::ExistsLoader.for(Book, :user_id, { name: "book3" }).load(has_book_user.id)
          end
          expect(result).to eq false
        }
      end

      context "name is match" do
        it {
          result = GraphQL::Batch.batch do
            Loaders::ExistsLoader.for(Book, :user_id, { name: "book1" }).load(has_book_user.id)
          end
          expect(result).to eq true
        }
      end
    end
  end
end
