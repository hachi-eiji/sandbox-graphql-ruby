# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loaders::RecordLoader do
  describe "#load" do
    let(:today) { Time.zone.today }
    let!(:user) { User.create!(name: "test") }
    let!(:has_book_user) { User.create!(name: "test") }
    let!(:book1) { Book.create!(name: "book1", user: has_book_user, purchase_on: today + 1.days) }
    let!(:book2) { Book.create!(name: "book2", user: has_book_user, purchase_on: today) }

    context "load user" do
      it {
        result = GraphQL::Batch.batch do
          Loaders::RecordLoader.for(User).load(book2.user_id)
        end
        expect(result).to eq has_book_user
      }
    end

    context "add condition" do
      it {
        result = GraphQL::Batch.batch do
          Loaders::RecordLoader.for(User, where: { name: "not found" }).load(book2.user_id)
        end
        expect(result).to eq nil
      }

      it {
        result = GraphQL::Batch.batch do
          Loaders::RecordLoader.for(User, where: { name: book2.user.name }).load(book2.user_id)
        end
        expect(result).to eq has_book_user
      }
    end
  end
end
