require "rails_helper"

RSpec.describe WebsiteLogoService do
  # <link href="/images/2016/ios/32x32.png" rel="icon" type="image/png" sizes="32x32" />
  # <link href="/images/2016/ios/180x180.png" rel="apple-touch-icon" sizes="180x180" />
  # <link href="/images/2016/ios/167x167.png" rel="apple-touch-icon" sizes="167x167" />
  # <link href="/images/2016/ios/152x152.png" rel="apple-touch-icon" sizes="152x152" />
  # <link href="/images/2016/ios/120x120.png" rel="apple-touch-icon" sizes="120x120" />
  # <link href="/images/2016/ios/80x80.png" rel="apple-touch-icon" sizes="80x80" />
  # <link href="/images/2016/ios/76x76.png" rel="apple-touch-icon" sizes="76x76" />
  # <link href="/images/2016/ios/40x40.png" rel="apple-touch-icon" sizes="40x40" />
  # <link href="/images/2016/ios/192x192.png" rel="icon" sizes="192x192" />
  # <link href="/images/2016/ios/128x128.png" rel="icon" sizes="128x128" />
  context "when it has sizes" do
    let(:service) { described_class.new("https://kottke.org/") }

    it "extracts the biggest size", :vcr do
      VCR.use_cassette("website_with_sizes_kottke_org") do
        url = service.call
        expect(url.include?("192x192.png")).to eq true
      end
    end

    it "adds the domain to relative paths", :vcr do
      VCR.use_cassette("website_with_sizes_kottke_org") do
        url = service.call
        expect(url.include?("https://kottke.org/")).to eq true
      end
    end
  end

  # <link rel="apple-touch-icon-precomposed" href="/graphics/apple-touch-icon.png" />
  # <link rel="shortcut icon" href="/graphics/favicon.ico?v=005" />
  context "when it has apple meta data" do
    let(:service) { described_class.new("https://daringfireball.net/") }

    it "extracts based on apple", :vcr do
      VCR.use_cassette("website_with_apple_meta_daringfireball_net") do
        url = service.call
        expect(url.include?("apple-touch-icon.png")).to eq true
      end
    end

    it "adds the domain to relative paths", :vcr do
      VCR.use_cassette("website_with_apple_meta_daringfireball_net") do
        url = service.call
        expect(url.include?("https://daringfireball.net/")).to eq true
      end
    end
  end

  context "when no fav icon" do
    let(:service) { described_class.new("https://mjtsai.com/blog/") }

    it "returns nil when no fav icon of any shape", :vcr do
      VCR.use_cassette("website_with_no_fav_icon_mjtsai_com") do
        expect(service.call).to eq nil
      end
    end
  end

  context "when url is nil" do
    let(:service) { described_class.new(nil) }

    it "short circuit with nil" do
      expect(service.call).to eq nil
    end
  end

  context "when only favicon is available" do
    let(:service) { described_class.new("https://shapeof.com/") }

    it "returns the favicon", :vcr do
      VCR.use_cassette("website_with_only_fav_icon_shapeof_com") do
        expect(service.call).to eq "http://shapeof.com/favicon.ico"
      end
    end
  end
end
