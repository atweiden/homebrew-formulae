class Tmux < Formula
  desc "Terminal multiplexer"
  homepage "https://tmux.github.io/"
  patch :DATA

  head do
    url "https://github.com/tmux/tmux.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libevent"

  resource "completion" do
    url "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/homebrew_1.0.0/completions/tmux"
    sha256 "05e79fc1ecb27637dc9d6a52c315b8f207cf010cdcee9928805525076c9020ae"
  end

  def install
    system "sh", "autogen.sh" if build.head?

    ENV.append "LDFLAGS", "-lresolv"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"

    system "make", "install"

    pkgshare.install "example_tmux.conf"
    bash_completion.install resource("completion")
  end

  def caveats; <<-EOS.undent
    Example configuration has been installed to:
      #{opt_pkgshare}
    EOS
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end

__END__
diff --git a/window-copy.c b/window-copy.c
index dfd0dc0..eea693b 100644
--- a/window-copy.c
+++ b/window-copy.c
@@ -689,8 +689,8 @@ window_copy_key(struct window_pane *wp, struct client *c, struct session *sess,
 	case MODEKEYCOPY_COPYPIPE:
 		if (sess != NULL) {
 			window_copy_copy_pipe(wp, sess, NULL, arg);
-			window_pane_reset_mode(wp);
-			return;
+			window_copy_clear_selection(wp);
+			window_copy_redraw_screen(wp);
 		}
 		break;
 	case MODEKEYCOPY_COPYSELECTION:
