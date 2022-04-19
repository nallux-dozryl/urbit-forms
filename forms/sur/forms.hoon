|%
+$  id        @uw
:: team
+$  team      (list @p)
:: metadata
+$  title      @t
+$  desc       @t
+$  birth      @da
+$  change     @da
+$  vis        ?(%pub %team %me)
+$  meta       [=title =desc =birth =vis =team]
:: =contents
+$  sid        @uw
+$  block      @t
+$  blocks     (list block)     
+$  section    [=title =desc =blocks]
+$  sections   (map =sid =section)
:: =shelf
+$  logic      @t  :: unused (wip)
+$  contents   (list sid)
+$  booklet    [=meta =contents]
+$  shelf      (map =id =booklet)
:: actions
+$  booklet-action
  $%  [%create =title =desc =vis]
      [%delete =id]
  ==
  ::
+$  meta-action
  $%  [%title =id =title]
      [%desc =id =desc]
      [%vis =id =vis]
  ==
  ::
+$  section-action
  $%  [%create =id =title =desc]
      [%delete =id =sid]
      [%title =sid =title]
      [%desc =sid =desc]
      [%dupe =id =sid]
  ==
--
