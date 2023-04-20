/-  sites
/+  login, server, verb, dbug, default-agent
/=  s-  /mar/sites-0
/*  fig  %sites-0  /config/sites-0
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 ~]
+$  eyre-id  @ta
+$  card  card:agent:gall
--
=|  state-0
=*  state  -
%-  agent:dbug
%+  verb  |
^-  agent:gall
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    hc    ~(. +> [bowl ~])
    cc    |=(cards=(list card) ~(. +> [bowl cards]))
::
++  on-init
  ^-  (quip card _this)
  :_  this
  [%pass /eyre/connect %arvo %e %connect [~ /site] dap.bowl]~
::
++  on-save  !>(state)
::
++  on-load
  |=  ole=vase
  ^-  (quip card _this)
  =/  old=state-0  !<(state-0 ole)
  [~ this(state old)]
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %handle-http-request
    ?>  =(src our):bowl
    =^  cards  state
      (handle-http:hc !<([@ta =inbound-request:eyre] vase))
    [cards this]
  ==
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  =(our.bowl src.bowl)
  ?+  path  (on-watch:def path)
    [%http-response *]  [~ this]
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    wire  (on-arvo:def wire sign-arvo)
      [%eyre %connect ~]
    ?+    sign-arvo  (on-arvo:def wire sign-arvo)
        [%eyre %bound *]
      ~?  !accepted.sign-arvo
        [dap.bowl 'eyre bind rejected!' binding.sign-arvo]
      [~ this]
    ==
  ==
++  on-fail   on-fail:def
--
|_  [=bowl:gall cards=(list card)]
+*  core  .
    lgn   ~(. login bowl)
++  abet  [(flop cards) state]
++  emit  |=(=card core(cards [card cards]))
++  emil  |=(cadz=(list card) core(cards (weld cadz cards)))
::
++  sour  (scot %p our.bowl)
++  snow  (scot %da now.bowl)
:: get config list with longest paths first
::
++  config
  ^-  config:sites
  =/  =config:sites  fig
  %=    config
      path-pairs
    %+  sort  path-pairs.config
    |*  [a=[=path *] b=[=path *]]
    (gth (lent path.a) (lent path.b))
  ==
::
++  config-map
  ^-  (map path (unit bloc-path:sites))
  %.  path-pairs:config
  ~(gas by *(map path (unit bloc-path:sites)))
:: from ~paldev's /lib/rudder/hoon
::
++  decap  ::  strip leading base from full site path
  |=  [base=(list @t) site=(list @t)]
  ^-  (unit (list @t))
  ?~  base  `site
  ?~  site  ~
  ?.  =(i.base i.site)  ~
  $(base t.base, site t.site)
::
++  get-bloc-path
  |=  =path
  ^-  (unit bloc-path:sites)
  =/  pairs=path-pairs:sites
    path-pairs:config
  |-  ?~  pairs  ~
  ?~  (decap p.i.pairs path)
    $(pairs t.pairs)
  q.i.pairs
::
++  four-oh-four
  |=  =eyre-id
  ^-  (list card)
  %+  give-simple-payload:app:server
    eyre-id
  :-  [404 ['Content-Type'^'text/html']~]
  `(as-octt:mimes:html "404 - Not Found")
::
++  give-file
  |=  [=eyre-id =request:http]
  ^-  (list card)
  |^
  ?~  pat=(rush url.request stap)  (four-oh-four eyre-id)
  ?.  ?=([%site ^] u.pat)  (four-oh-four eyre-id)
  =/  site=path  t.u.pat
  =/  [nem=@t ext=@t]
    =-  ?^(- - [- %html])
    =/  calp  (cook crip (star alp))
    (rash (rear site) ;~(pose ;~((glue dot) calp calp) calp))
  ::
  =/  [content-type=@t =path]
    ?+  ext    !!
        %'css'
      ['text/css; charset=utf-8' (en-path site /[nem]/css)]
      ::
        %'html'
      ['text/html; charset=utf-8' (en-path site /[nem]/html)]
    ==
  ::
  ?.  (has path)  (four-oh-four eyre-id)
  %+  give-simple-payload:app:server
    eyre-id
  :-  [200 ['Content-Type' content-type]~]
  (some (as-octs:mimes:html (file path)))
  ::
  ++  has   |=(=path .^(? %cu (weld /[sour]/[dap.bowl]/[snow] path)))
  ++  file  |=(=path .^(@ %cx (weld /[sour]/[dap.bowl]/[snow] path)))
  ++  en-path
    |=  [site=path file=path]
    ^-  path
    =/  tise  (flop site)
    ?>  ?=(^ tise)
    :(weld /app/files (flop t.tise) file)
  --
::
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^-  (quip card _state)
  =/  rl=request-line:server
    (parse-request-line:server url.request.inbound-request)
  ::
  =/  bloc=(unit bloc-path:lgn)
    (get-bloc-path ?>(?=([%site *] site.rl) t.site.rl))
  =;  give
    ?~  bloc  give
    =+  usr=(authenticated:lgn u.bloc request.inbound-request)
    ?:  |(?=(^ usr) authenticated.inbound-request)  give :: always allow host ship
    :_(state (bloc-login-redirect:lgn eyre-id u.bloc (spat site.rl)))
  ::
  ?+    method.request.inbound-request  
    :_(state (four-oh-four eyre-id))
    ::
      %'GET'
      :_  state 
      %+  give-file
        eyre-id
      request.inbound-request
  ==
--
