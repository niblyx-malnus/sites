/+  sites
|_  =config:sites
++  grow
  |%
  ++  mime  
    ^-  ^mime
    :-  /text/x-site-config
    %-  as-octt:mimes:html
    (spit-config:mime:sites (validate:sites config))
  ++  noun  (validate:sites config)
  ++  json  (config:enjs:sites (validate:sites config))
  --
++  grab
  |%
  ::
  ++  mime
    |=  [=mite len=@ud tex=@]
    ^-  config:sites
    %-  validate:sites
    [%0 (path-pairs:sites !<(path-pairs:sites (slap !>(~) (ream tex))))]

  ::
  ++  noun  config:sites
  --
++  grad  %noun
--
