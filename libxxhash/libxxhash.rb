class Libxxhash < Formula
  desc "Extremely fast non-cryptographic hash algorithm (library)"
  homepage "https://cyan4973.github.io/xxHash/"
  url "https://github.com/Cyan4973/xxHash/archive/v0.7.2.tar.gz"
  sha256 "7e93d28e81c3e95ff07674a400001d0cdf23b7842d49b211e5582d00d8e3ac3e"
  head "https://github.com/Cyan4973/xxHash.git"

  def install
    system "make", "lib"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    true
  end
end
