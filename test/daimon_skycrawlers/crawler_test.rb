require 'test_helper'

class DaimonSkycrawlersCrawlerTest < Test::Unit::TestCase
  sub_test_case 'fetch html' do
    setup do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get("/") {|env|
          [200, {}, "body"]
        }
      end
      @crawler = ::DaimonSkycrawlers::Crawler.new('http://example.com')
      @crawler.setup_connection do |faraday|
        faraday.adapter :test, stubs
      end
      @crawler.storage = DaimonSkycrawlers::Storage::Null.new
    end

    def test_on_fetch
      @crawler.fetch("/") do |url, headers, body|
        assert_equal("http://example.com/", url)
        assert_equal({}, headers)
        assert_equal("body", body)
      end
    end
  end

  sub_test_case 'filter' do
    setup do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get("/blog") {|env|
          [200, {}, fixture_path("www.clear-code.com/blog.html").read]
        }
      end
      @crawler = ::DaimonSkycrawlers::Crawler.new('http://example.com')
      @crawler.setup_connection do |faraday|
        faraday.adapter :test, stubs
      end
      @crawler.storage = DaimonSkycrawlers::Storage::Null.new
    end

    def test_fetch_blog
      @crawler.fetch("./blog", depth: 1)
    end
  end
end
