# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loaders::AssociationLoader do
  describe "#load" do
    let(:today) { Time.zone.today }
    let!(:user) { User.create!(name: "test") }
    let!(:has_book_user) { User.create!(name: "test") }
    let!(:book1) { Book.create!(name: "book1", user: has_book_user, purchase_on: today + 1.days) }
    let!(:book2) { Book.create!(name: "book2", user: has_book_user, purchase_on: today) }

    context "user does not have a book" do
      it "get empty" do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(User, :books).load(user)
        end
        expect(result).to be_empty
      end
    end

    context "user have books" do
      it "should have books" do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(User, :books).load(has_book_user)
        end
        expect(result).to include(book1, book2)
      end
    end

    context "argument sort" do
      it 'should sorted by purchase_on asc' do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(User, :books, orders: { purchase_on: :asc }).load(has_book_user)
        end

        expect(result).to eq([book2, book1])
      end
    end

    context "call has_many with scope" do
      it 'should sorted by purchase_on asc' do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(User, :purchase_books).load(has_book_user)
        end

        expect(result).to eq([book2, book1])
      end
    end

    context "add condition" do
      it "should filter" do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(User, :purchase_books, where: { name: "book2" }).load(has_book_user)
        end

        expect(result).to eq([book2])
      end
    end

    context "add other scope" do
      it "should filter" do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(User, :books, scope_names: :old_books).load(has_book_user)
        end

        expect(result).to eq([book1, book2])
      end
    end

    context "multi scope" do
      it "should filter" do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(User, :books, scope_names: [:old_books, :order_purchase_on]).load(has_book_user)
        end

        expect(result).to eq([book2, book1])
      end

      it "should filter" do
        result = GraphQL::Batch.batch do
          Loaders::AssociationLoader.for(User, :purchase_books, scope_names: [:old_books, :order_id]).load(has_book_user)
        end

        expect(result).to eq([book2, book1])
      end
    end
  end
end
