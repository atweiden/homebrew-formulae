class Enchive < Formula
  desc "Encrypted personal archives"
  homepage "https://github.com/skeeto/enchive"
  url "https://github.com/skeeto/enchive/archive/3.5.tar.gz"
  sha256 "e66d0417db2bcc7ddd2dea1e0e1e88df6b4be07e85173710cba254af342585ef"
  head "https://github.com/skeeto/enchive.git"

  depends_on "make" => :build

  def install
    ENV.append "CFLAGS", "-ansi -pedantic -Wall -Wextra -O3 -g3"
    ENV.append "CFLAGS", "-D_FILE_OFFSET_BITS=64"
    ENV.append "CFLAGS", "-DENCHIVE_AGENT_TIMEOUT=420"
    ENV.append "CFLAGS", "-DENCHIVE_FILE_EXTENSION='.enc'"
    inreplace "Makefile" do |s|
      s.change_make_var! "CFLAGS", ENV['CFLAGS']
    end
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    true
  end
end
