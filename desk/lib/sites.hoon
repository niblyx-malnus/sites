/-  *sites
|%
++  validate
  |=  =config
  ^-  ^config
  =+  pairs=path-pairs.config
  ~|  %duplicate-paths
  ?>  .=  (lent pairs)
      ~(wyt in (sy (turn pairs head)))
  config
::
++  mime
  |%
  ++  spit-pair
    |=  [=path bloc=(unit bloc-path)]
    ^-  tape
    =/  bloc-tape=tape  ?~(bloc "~" "`{(spud u.bloc)}")
    "[{(spud path)} {bloc-tape}]"
  ::
  ++  spit-config
    |=  =config
    ^-  tape
    ;:  welp
      ":~\0a"
      `tape`(zing (join "\0a" (turn path-pairs.config spit-pair)))
      "\0a=="
    ==
  --
::
++  enjs
  =,  enjs:format
  |%
  ++  config
    |=  c=^config
    ^-  json
    :-  %a
    %+  turn  path-pairs.c 
    |=  [=^path bloc=(unit bloc-path)]
    ^-  json
    %-  pairs
    :~  path+s+(spat path)
        bloc+?~(bloc ~ s+(spat u.bloc))
    ==
  --
--
