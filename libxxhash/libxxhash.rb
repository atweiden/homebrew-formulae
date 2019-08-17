class Libxxhash < Formula
  desc "Extremely fast non-cryptographic hash algorithm (library)"
  homepage "https://cyan4973.github.io/xxHash/"
  url "https://github.com/Cyan4973/xxHash/archive/v0.7.1.tar.gz"
  sha256 "afa29766cfc0448ff4a1fd9f2c47e02c48d50be5b79749925d15d545008c3f81"
  head "https://github.com/Cyan4973/xxHash.git"

  def install
    system "make", "lib"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    true
  end
end
