let
  raw_urls = with builtins;
    (filter (u: isString (u) && stringLength (u) > 0))
    (split "\n" (readFile ../newsboat_urls));

  urls = map (u: { url = u; }) raw_urls;
in {
  programs.newsboat = {
    inherit urls;
    enable = true;
  };
}
