FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l      �� 	 
��   		c	] Make cues from a text file: add cues from a tab-delimited text file to a workspace in QLab based on the data in the file;
    see second & third display dialogs for further explanation
 
This script is not designed to be run from within QLab!
 
v0.0: 06/10/09 Rich Walsh (very early, barely-written, proof of concept)
v0.5: 06/10/09 Starting to finish basic shape; have cracked groups & levels (I think)
v0.9: 07/10/09 Fixed a couple of mistakes; finished creating all commands
v0.9.1: 12/10/09 Snow Leopard can't "get running", so rewrote a sequence; also added some more instructions and the option to set
        a common root path for media; corrected some more mistakes; changed ETA
v0.9.2: 16/10/09 Now "tested" in Snow Leopard; expanded makeNiceT for hours; general tidying; updates for QLab 2.2.5; new ETA figures
v0.9.3: 27/10/09 Added MSC translation; new note about file targets
v1.0: 11/01/10 Added better text-cleaning routine; "start value" is read-only, so fixed that; byte combo (and related) origin offset; corrected minor typos;
        added tell front workspace for elegance; wrapped text for better wiki experience; implemented dialogTitle for cross-script pillaging
 
<<< Last tested with: QLab 2.2.6; Mac OS 10.5.8 & 10.6.2 >>>
 
<<< A LITTLE DISCLAIMER: This was quite a complex bit of work for me, so I make no guarantees whatsoever that it will work for you: if it does, use it;
    if it doesn't, I'd like to know, but I may choose not to do anything about it... >>>
 
***CUSTOMISATION***
 
If you would prefer not to use the terms from QLab's AppleScript dictionary it is relatively painless to personalise this script
(although you should record what you've done so you can repeat it if the script ever gets updated,
and please DON'T release your private version into the wild!). 
 
To change the strings that you need to use in the first row of your text file to associate a column with a property,
edit the relevant entry in the "set acceptableColumnHeaders" line, eg: change "continue mode" to "f/on" if you prefer
(just don't use commas - they identify level-setting columns).
 
To change the strings that you need to use in the rows to call a QLab constant, edit the contents of the relevant
"set constantsXXX" line, eg: change "set constants10_continue_mode" entries from "do_not_continue", "auto_continue" & "auto_follow"
to "no", "a/c" & "a/f" if you prefer.     
 �  �   M a k e   c u e s   f r o m   a   t e x t   f i l e :   a d d   c u e s   f r o m   a   t a b - d e l i m i t e d   t e x t   f i l e   t o   a   w o r k s p a c e   i n   Q L a b   b a s e d   o n   t h e   d a t a   i n   t h e   f i l e ; 
         s e e   s e c o n d   &   t h i r d   d i s p l a y   d i a l o g s   f o r   f u r t h e r   e x p l a n a t i o n 
   
 T h i s   s c r i p t   i s   n o t   d e s i g n e d   t o   b e   r u n   f r o m   w i t h i n   Q L a b ! 
   
 v 0 . 0 :   0 6 / 1 0 / 0 9   R i c h   W a l s h   ( v e r y   e a r l y ,   b a r e l y - w r i t t e n ,   p r o o f   o f   c o n c e p t ) 
 v 0 . 5 :   0 6 / 1 0 / 0 9   S t a r t i n g   t o   f i n i s h   b a s i c   s h a p e ;   h a v e   c r a c k e d   g r o u p s   &   l e v e l s   ( I   t h i n k ) 
 v 0 . 9 :   0 7 / 1 0 / 0 9   F i x e d   a   c o u p l e   o f   m i s t a k e s ;   f i n i s h e d   c r e a t i n g   a l l   c o m m a n d s 
 v 0 . 9 . 1 :   1 2 / 1 0 / 0 9   S n o w   L e o p a r d   c a n ' t   " g e t   r u n n i n g " ,   s o   r e w r o t e   a   s e q u e n c e ;   a l s o   a d d e d   s o m e   m o r e   i n s t r u c t i o n s   a n d   t h e   o p t i o n   t o   s e t 
                 a   c o m m o n   r o o t   p a t h   f o r   m e d i a ;   c o r r e c t e d   s o m e   m o r e   m i s t a k e s ;   c h a n g e d   E T A 
 v 0 . 9 . 2 :   1 6 / 1 0 / 0 9   N o w   " t e s t e d "   i n   S n o w   L e o p a r d ;   e x p a n d e d   m a k e N i c e T   f o r   h o u r s ;   g e n e r a l   t i d y i n g ;   u p d a t e s   f o r   Q L a b   2 . 2 . 5 ;   n e w   E T A   f i g u r e s 
 v 0 . 9 . 3 :   2 7 / 1 0 / 0 9   A d d e d   M S C   t r a n s l a t i o n ;   n e w   n o t e   a b o u t   f i l e   t a r g e t s 
 v 1 . 0 :   1 1 / 0 1 / 1 0   A d d e d   b e t t e r   t e x t - c l e a n i n g   r o u t i n e ;   " s t a r t   v a l u e "   i s   r e a d - o n l y ,   s o   f i x e d   t h a t ;   b y t e   c o m b o   ( a n d   r e l a t e d )   o r i g i n   o f f s e t ;   c o r r e c t e d   m i n o r   t y p o s ; 
                 a d d e d   t e l l   f r o n t   w o r k s p a c e   f o r   e l e g a n c e ;   w r a p p e d   t e x t   f o r   b e t t e r   w i k i   e x p e r i e n c e ;   i m p l e m e n t e d   d i a l o g T i t l e   f o r   c r o s s - s c r i p t   p i l l a g i n g 
   
 < < <   L a s t   t e s t e d   w i t h :   Q L a b   2 . 2 . 6 ;   M a c   O S   1 0 . 5 . 8   &   1 0 . 6 . 2   > > > 
   
 < < <   A   L I T T L E   D I S C L A I M E R :   T h i s   w a s   q u i t e   a   c o m p l e x   b i t   o f   w o r k   f o r   m e ,   s o   I   m a k e   n o   g u a r a n t e e s   w h a t s o e v e r   t h a t   i t   w i l l   w o r k   f o r   y o u :   i f   i t   d o e s ,   u s e   i t ; 
         i f   i t   d o e s n ' t ,   I ' d   l i k e   t o   k n o w ,   b u t   I   m a y   c h o o s e   n o t   t o   d o   a n y t h i n g   a b o u t   i t . . .   > > > 
   
 * * * C U S T O M I S A T I O N * * * 
   
 I f   y o u   w o u l d   p r e f e r   n o t   t o   u s e   t h e   t e r m s   f r o m   Q L a b ' s   A p p l e S c r i p t   d i c t i o n a r y   i t   i s   r e l a t i v e l y   p a i n l e s s   t o   p e r s o n a l i s e   t h i s   s c r i p t 
 ( a l t h o u g h   y o u   s h o u l d   r e c o r d   w h a t   y o u ' v e   d o n e   s o   y o u   c a n   r e p e a t   i t   i f   t h e   s c r i p t   e v e r   g e t s   u p d a t e d , 
 a n d   p l e a s e   D O N ' T   r e l e a s e   y o u r   p r i v a t e   v e r s i o n   i n t o   t h e   w i l d ! ) .   
   
 T o   c h a n g e   t h e   s t r i n g s   t h a t   y o u   n e e d   t o   u s e   i n   t h e   f i r s t   r o w   o f   y o u r   t e x t   f i l e   t o   a s s o c i a t e   a   c o l u m n   w i t h   a   p r o p e r t y , 
 e d i t   t h e   r e l e v a n t   e n t r y   i n   t h e   " s e t   a c c e p t a b l e C o l u m n H e a d e r s "   l i n e ,   e g :   c h a n g e   " c o n t i n u e   m o d e "   t o   " f / o n "   i f   y o u   p r e f e r 
 ( j u s t   d o n ' t   u s e   c o m m a s   -   t h e y   i d e n t i f y   l e v e l - s e t t i n g   c o l u m n s ) . 
   
 T o   c h a n g e   t h e   s t r i n g s   t h a t   y o u   n e e d   t o   u s e   i n   t h e   r o w s   t o   c a l l   a   Q L a b   c o n s t a n t ,   e d i t   t h e   c o n t e n t s   o f   t h e   r e l e v a n t 
 " s e t   c o n s t a n t s X X X "   l i n e ,   e g :   c h a n g e   " s e t   c o n s t a n t s 1 0 _ c o n t i n u e _ m o d e "   e n t r i e s   f r o m   " d o _ n o t _ c o n t i n u e " ,   " a u t o _ c o n t i n u e "   &   " a u t o _ f o l l o w " 
 t o   " n o " ,   " a / c "   &   " a / f "   i f   y o u   p r e f e r .        l     ��������  ��  ��        l     ��  ��    5 / ###FIXME### See 2x embedded comments in script     �   ^   # # # F I X M E # # #   S e e   2 x   e m b e d d e d   c o m m e n t s   i n   s c r i p t      l     ��  ��    x r ###FIXME### QLab throws an error when trying to get/set smpte format for an MSC Cue (checked in 2.2.6 Build 1084)     �   �   # # # F I X M E # # #   Q L a b   t h r o w s   a n   e r r o r   w h e n   t r y i n g   t o   g e t / s e t   s m p t e   f o r m a t   f o r   a n   M S C   C u e   ( c h e c k e d   i n   2 . 2 . 6   B u i l d   1 0 8 4 )      l     ��  ��    � � ###FIXME### QLab and/or the "script runner" is, generally, increasingly unresponsive to scripts the more cues there are in a workspace     �     # # # F I X M E # # #   Q L a b   a n d / o r   t h e   " s c r i p t   r u n n e r "   i s ,   g e n e r a l l y ,   i n c r e a s i n g l y   u n r e s p o n s i v e   t o   s c r i p t s   t h e   m o r e   c u e s   t h e r e   a r e   i n   a   w o r k s p a c e      l     ��   ��    C = ###FIXME### Review dialogs in light of this (especially ETA)      � ! ! z   # # # F I X M E # # #   R e v i e w   d i a l o g s   i n   l i g h t   o f   t h i s   ( e s p e c i a l l y   E T A )   " # " l     �� $ %��   $ V P ###ADD### Skip level setting for rows beyond number of audio input channels (?)    % � & & �   # # # A D D # # #   S k i p   l e v e l   s e t t i n g   f o r   r o w s   b e y o n d   n u m b e r   o f   a u d i o   i n p u t   c h a n n e l s   ( ? ) #  ' ( ' l     �� ) *��   ) � � ###ADD### Maybe one day make it possible to make cuelists (NB: simpling changing the mode of a Group Cue to cue_list _doesn't_ do it!)    * � + +   # # # A D D # # #   M a y b e   o n e   d a y   m a k e   i t   p o s s i b l e   t o   m a k e   c u e l i s t s   ( N B :   s i m p l i n g   c h a n g i n g   t h e   m o d e   o f   a   G r o u p   C u e   t o   c u e _ l i s t   _ d o e s n ' t _   d o   i t ! ) (  , - , l     ��������  ��  ��   -  . / . l     �� 0 1��   0   Declarations    1 � 2 2    D e c l a r a t i o n s /  3 4 3 l     ��������  ��  ��   4  5 6 5 p       7 7 ������ 0 dialogtitle dialogTitle��   6  8 9 8 l     :���� : r      ; < ; m      = = � > > 4 M a k e   c u e s   f r o m   a   t e x t   f i l e < o      ���� 0 dialogtitle dialogTitle��  ��   9  ? @ ? l     ��������  ��  ��   @  A B A p       C C ������ 0 currenttids currentTIDs��   B  D E D l   	 F���� F r    	 G H G n    I J I 1    ��
�� 
txdl J 1    ��
�� 
ascr H o      ���� 0 currenttids currentTIDs��  ��   E  K L K l     ��������  ��  ��   L  M N M l  
 � O P Q O r   
 � R S R J   
 � T T  U V U m   
  W W � X X  t y p e V  Y Z Y m     [ [ � \ \  q   n u m b e r Z  ] ^ ] m     _ _ � ` `  q   n a m e ^  a b a m     c c � d d 
 n o t e s b  e f e m     g g � h h  c u e   t a r g e t f  i j i m     k k � l l  f i l e   t a r g e t j  m n m m     o o � p p  p r e   w a i t n  q r q m     s s � t t  d u r a t i o n r  u v u m     w w � x x  p o s t   w a i t v  y z y m     { { � | |  c o n t i n u e   m o d e z  } ~ } l 	   ����  m     � � � � � 
 a r m e d��  ��   ~  � � � m     � � � � �  m i d i   t r i g g e r �  � � � m     � � � � �  m i d i   c o m m a n d �  � � � m     � � � � �  m i d i   b y t e   o n e �  � � � m    ! � � � � �  m i d i   b y t e   t w o �  � � � m   ! $ � � � � �   t i m e c o d e   t r i g g e r �  � � � m   $ ' � � � � � $ w a l l   c l o c k   t r i g g e r �  � � � m   ' * � � � � �   w a l l   c l o c k   h o u r s �  � � � m   * - � � � � � $ w a l l   c l o c k   m i n u t e s �  � � � l 	 - 0 ����� � m   - 0 � � � � � $ w a l l   c l o c k   s e c o n d s��  ��   �  � � � m   0 3 � � � � �  m o d e �  � � � m   3 6 � � � � �   s y n c   t o   t i m e c o d e �  � � � m   6 9 � � � � �  s y n c   m o d e �  � � � m   9 < � � � � �  s m p t e   f o r m a t �  � � � m   < ? � � � � � ( m t c   s y n c   s o u r c e   n a m e �  � � � m   ? B � � � � �   l t c   s y n c   c h a n n e l �  � � � m   B E � � � � � 
 p a t c h �  � � � m   E H � � � � �  s t a r t   t i m e �  � � � m   H K � � � � �  e n d   t i m e �  � � � l 	 K N ����� � m   K N � � � � �  l o o p   s t a r t   t i m e��  ��   �  � � � m   N Q � � � � �  l o o p   e n d   t i m e �  � � � m   Q T � � � � �  l o o p   c o u n t �  � � � m   T W � � � � �  i n f i n i t e   l o o p �  � � � m   W Z � � � � �  g u a r a n t e e   s y n c �  � � � m   Z ] � � � � �  i n t e g r a t e d   f a d e �  � � � m   ] ` � � � � �  f a d e   m o d e �  � � � m   ` c � � � � � * s t o p   t a r g e t   w h e n   d o n e �  � � � m   c f � � � � �  a u t o   s t o p �  � � � m   f i � � � � � 
 l a y e r �  � � � l 	 i l ����� � m   i l � � � � �  f u l l   s c r e e n��  ��   �  � � � m   l o � � � � � * p r e s e r v e   a s p e c t   r a t i o �  � � � m   o r � � �    o p a c i t y �  m   r u �  t r a n s l a t i o n   x  m   u x �  t r a n s l a t i o n   y 	
	 m   x { �  r o t a t i o n
  m   { ~ �  s c a l e   x  m   ~ � �  s c a l e   y  m   � � �  s c a l e   l o c k e d  m   � � �   c u s t o m   r e n d e r i n g  m   � � �    d o   o p a c i t y !"! l 	 � �#����# m   � �$$ �%%  d o   t r a n s l a t i o n��  ��  " &'& m   � �(( �))  d o   r o t a t i o n' *+* m   � �,, �--  d o   s c a l e+ ./. m   � �00 �11  c o m m a n d/ 232 m   � �44 �55  c h a n n e l3 676 m   � �88 �99  b y t e   o n e7 :;: m   � �<< �==  b y t e   t w o; >?> m   � �@@ �AA  b y t e   c o m b o? BCB m   � �DD �EE  e n d   v a l u eC FGF m   � �HH �II  f a d eG JKJ m   � �LL �MM  c o m m a n d   f o r m a tK NON l 	 � �P����P m   � �QQ �RR  c o m m a n d   n u m b e r��  ��  O STS m   � �UU �VV  q _ n u m b e rT WXW m   � �YY �ZZ  q _ l i s tX [\[ m   � �]] �^^  q _ p a t h\ _`_ m   � �aa �bb 
 m a c r o` cdc m   � �ee �ff  c o n t r o l   n u m b e rd ghg m   � �ii �jj  c o n t r o l   v a l u eh klk m   � �mm �nn 
 h o u r sl opo m   � �qq �rr  m i n u t e sp sts m   � �uu �vv  s e c o n d st wxw m   � �yy �zz  f r a m e sx {|{ m   � �}} �~~  s u b f r a m e s| � l 	 � ������� m   � ��� ��� $ s e n d   t i m e   w i t h   s e t��  ��  � ��� m   � ��� ���  s y s e x   m e s s a g e� ��� m   � ��� ���   m i d i   d e s t i n a t i o n� ��� m   � ��� ��� " s t a r t   t i m e   o f f s e t� ��� m   � ��� ��� 8 f i r e   n e x t   c u e   w h e n   l o o p   e n d s� ��� m   � ��� ��� 4 s t o p   t a r g e t   w h e n   l o o p   e n d s� ��� m   � ��� ���  l o a d   t i m e� ���� l 	 � ������� m   � ��� ���  a s s i g n e d   n u m b e r��  ��  ��   S o      ���� 20 acceptablecolumnheaders acceptableColumnHeaders P [ U All possible properties (order is based on entries in QLab's AppleScript dictionary)    Q ��� �   A l l   p o s s i b l e   p r o p e r t i e s   ( o r d e r   i s   b a s e d   o n   e n t r i e s   i n   Q L a b ' s   A p p l e S c r i p t   d i c t i o n a r y ) N ��� l     ��������  ��  ��  � ��� l  � ����� r   � ���� J   � ��� ���� m   � ��� ���  p u t   i n   g r o u p��  � o      ���� *0 customcolumnheaders customColumnHeaders� 5 / Additional columns this script will understand   � ��� ^   A d d i t i o n a l   c o l u m n s   t h i s   s c r i p t   w i l l   u n d e r s t a n d� ��� l  ������� X   ������ s  ��� c  ��� o  ���� 0 eachitem eachItem� m  ��
�� 
TEXT� n      ���  ;  � o  ���� 20 acceptablecolumnheaders acceptableColumnHeaders�� 0 eachitem eachItem� o   � ���� *0 customcolumnheaders customColumnHeaders��  ��  � ��� l     ��������  ��  ��  � ��� l  /���� r   /��� J   +�� ��� m   #�� ���  u n i q u e   I D� ��� m  #&�� ���  b r o k e n� ���� m  &)�� ��� ( a u d i o   i n p u t   c h a n n e l s��  � o      ���� ,0 reportingonlycolumns reportingOnlyColumns� H B Not needed in this script; for reference {text, boolean, integer}   � ��� �   N o t   n e e d e d   i n   t h i s   s c r i p t ;   f o r   r e f e r e n c e   { t e x t ,   b o o l e a n ,   i n t e g e r }� ��� l     ��������  ��  ��  � ��� l 06���� r  06��� J  02����  � o      ���� 0 levelcolumns levelColumns� D > If a column header contains "," it will be added to this list   � ��� |   I f   a   c o l u m n   h e a d e r   c o n t a i n s   " , "   i t   w i l l   b e   a d d e d   t o   t h i s   l i s t� ��� l     ��������  ��  ��  � ��� l 7����� r  7���� J  7��� ��� m  7:�� ��� 
 G r o u p� ��� m  :=�� ��� 
 A u d i o� ��� m  =@�� ���  F a d e� ��� m  @C�� ��� 
 V i d e o� ��� m  CF�� ���  A n i m a t i o n� ��� m  FI�� ���  C a m e r a� ��� m  IL�� ���  M I D I�    m  LO �  M S C  m  OR �  M I D I   S y s E x 	 m  RU

 �  M T C	  m  UX � 
 S t a r t  m  X[ �  S t o p  m  [^ � 
 P a u s e  m  ^a � 
 R e s e t  l 	ad���� m  ad �    D e v a m p��  ��   !"! m  dg## �$$  L o a d" %&% m  gj'' �((  S c r i p t& )*) m  jm++ �,,  G o t o* -.- m  mp// �00  T a r g e t. 121 m  ps33 �44  W a i t2 565 m  sv77 �88  M e m o6 9:9 m  vy;; �<<  A r m: =>= m  y|?? �@@  D i s a r m> A��A m  |BB �CC  S o u n d M a n��  � o      ���� "0 acceptabletypes acceptableTypes� E ? The script will not process "Cue List" as it is too cumbersome   � �DD ~   T h e   s c r i p t   w i l l   n o t   p r o c e s s   " C u e   L i s t "   a s   i t   i s   t o o   c u m b e r s o m e� EFE l     ��������  ��  ��  F GHG l     ��IJ��  I E ? This is a list of properties that can be set for each cue type   J �KK ~   T h i s   i s   a   l i s t   o f   p r o p e r t i e s   t h a t   c a n   b e   s e t   f o r   e a c h   c u e   t y p eH LML l     ��������  ��  ��  M NON l     ��PQ��  P 9 3 set index2_q_number: every cue has q number (text)   Q �RR f   s e t   i n d e x 2 _ q _ n u m b e r :   e v e r y   c u e   h a s   q   n u m b e r   ( t e x t )O STS l     ��UV��  U 5 / set index3_q_name: every cue has q name (text)   V �WW ^   s e t   i n d e x 3 _ q _ n a m e :   e v e r y   c u e   h a s   q   n a m e   ( t e x t )T XYX l     ��Z[��  Z 3 - set index4_notes: every cue has notes (text)   [ �\\ Z   s e t   i n d e x 4 _ n o t e s :   e v e r y   c u e   h a s   n o t e s   ( t e x t )Y ]^] l ��_`a_ r  ��bcb J  ��dd efe m  ��gg �hh  F a d ef iji m  ��kk �ll  A n i m a t i o nj mnm m  ��oo �pp 
 S t a r tn qrq m  ��ss �tt  S t o pr uvu m  ��ww �xx 
 P a u s ev yzy m  ��{{ �|| 
 R e s e tz }~} m  �� ���  D e v a m p~ ��� m  ���� ���  L o a d� ��� m  ���� ���  G o t o� ��� m  ���� ���  T a r g e t� ��� m  ���� ���  A r m� ���� m  ���� ���  D i s a r m��  c o      ���� 0 index5_cue_target  `   (cue)   a ���    ( c u e )^ ��� l ������ r  ����� J  ���� ��� m  ���� ��� 
 A u d i o� ���� m  ���� ��� 
 V i d e o��  � o      ���� 0 index6_file_target  �   (file)   � ���    ( f i l e )� ��� l     ������  � 9 3 set index7_pre_wait: every cue has pre wait (real)   � ��� f   s e t   i n d e x 7 _ p r e _ w a i t :   e v e r y   c u e   h a s   p r e   w a i t   ( r e a l )� ��� l ������ r  ����� J  ���� ��� m  ���� ���  F a d e� ��� m  ���� ���  A n i m a t i o n� ��� m  ���� ���  C a m e r a� ��� m  ���� ���  M I D I� ���� m  ���� ���  W a i t��  � o      ���� 0 index8_duration  � D > Duration of Audio & Video cues can't be set, only read (real)   � ��� |   D u r a t i o n   o f   A u d i o   &   V i d e o   c u e s   c a n ' t   b e   s e t ,   o n l y   r e a d   ( r e a l )� ��� l     ������  � ; 5 set index9_post_wait: every cue has post wait (real)   � ��� j   s e t   i n d e x 9 _ p o s t _ w a i t :   e v e r y   c u e   h a s   p o s t   w a i t   ( r e a l )� ��� l     ������  � I C set index10_continue_mode: every cue has continue mode (constants)   � ��� �   s e t   i n d e x 1 0 _ c o n t i n u e _ m o d e :   e v e r y   c u e   h a s   c o n t i n u e   m o d e   ( c o n s t a n t s )� ��� l     ������  � 7 1 set index11_armed: every cue has armed (boolean)   � ��� b   s e t   i n d e x 1 1 _ a r m e d :   e v e r y   c u e   h a s   a r m e d   ( b o o l e a n )� ��� l     ������  � G A set index12_midi_trigger: every cue has midi trigger (constants)   � ��� �   s e t   i n d e x 1 2 _ m i d i _ t r i g g e r :   e v e r y   c u e   h a s   m i d i   t r i g g e r   ( c o n s t a n t s )� ��� l     ������  � G A set index13_midi_command: every cue has midi command (constants)   � ��� �   s e t   i n d e x 1 3 _ m i d i _ c o m m a n d :   e v e r y   c u e   h a s   m i d i   c o m m a n d   ( c o n s t a n t s )� ��� l     ������  � G A set index14_midi_byte_one: every cue has midi byte one (integer)   � ��� �   s e t   i n d e x 1 4 _ m i d i _ b y t e _ o n e :   e v e r y   c u e   h a s   m i d i   b y t e   o n e   ( i n t e g e r )� ��� l     ������  � G A set index15_midi_byte_two: every cue has midi byte two (integer)   � ��� �   s e t   i n d e x 1 5 _ m i d i _ b y t e _ t w o :   e v e r y   c u e   h a s   m i d i   b y t e   t w o   ( i n t e g e r )� ��� l     ������  � O I set index16_timecode_trigger: every cue has timecode trigger (constants)   � ��� �   s e t   i n d e x 1 6 _ t i m e c o d e _ t r i g g e r :   e v e r y   c u e   h a s   t i m e c o d e   t r i g g e r   ( c o n s t a n t s )� ��� l     ������  � S M set index17_wall_clock_trigger: every cue has wall clock trigger (constants)   � ��� �   s e t   i n d e x 1 7 _ w a l l _ c l o c k _ t r i g g e r :   e v e r y   c u e   h a s   w a l l   c l o c k   t r i g g e r   ( c o n s t a n t s )� ��� l     ������  � M G set index18_wall_clock_hours: every cue has wall clock hours (integer)   � ��� �   s e t   i n d e x 1 8 _ w a l l _ c l o c k _ h o u r s :   e v e r y   c u e   h a s   w a l l   c l o c k   h o u r s   ( i n t e g e r )� ��� l     ������  � Q K set index19_wall_clock_minutes: every cue has wall clock minutes (integer)   � ��� �   s e t   i n d e x 1 9 _ w a l l _ c l o c k _ m i n u t e s :   e v e r y   c u e   h a s   w a l l   c l o c k   m i n u t e s   ( i n t e g e r )� ��� l     ��� ��  � Q K set index20_wall_clock_seconds: every cue has wall clock seconds (integer)     � �   s e t   i n d e x 2 0 _ w a l l _ c l o c k _ s e c o n d s :   e v e r y   c u e   h a s   w a l l   c l o c k   s e c o n d s   ( i n t e g e r )�  l �� r  �� J  ��		 

 m  �� �  C u e   L i s t �� m  �� � 
 G r o u p��   o      ���� 0 index21_mode     (constants)    �    ( c o n s t a n t s )  l �� r  �� J  �� �� m  �� �  C u e   L i s t��   o      ���� 0 index22_sync_to_timecode     (constants)    �    ( c o n s t a n t s )  l �� !"  r  ��#$# J  ��%% &��& m  ��'' �((  C u e   L i s t��  $ o      ���� 0 index23_sync_mode  !   (constants)   " �))    ( c o n s t a n t s ) *+* l �,-., r  �/0/ J  �11 232 m  ��44 �55  C u e   L i s t3 6��6 m  �77 �88  M T C��  0 o      ���� 0 index24_smpte_format  - N H (constants) ###FIXME### "MSC" removed from list as QLab throws an error   . �99 �   ( c o n s t a n t s )   # # # F I X M E # # #   " M S C "   r e m o v e d   f r o m   l i s t   a s   Q L a b   t h r o w s   a n   e r r o r+ :;: l <=>< r  ?@? J  AA B��B m  CC �DD  C u e   L i s t��  @ o      ����  0 index25_mtc_sync_source_name  =   (text)   > �EE    ( t e x t ); FGF l HIJH r  KLK J  MM N��N m  OO �PP  C u e   L i s t��  L o      ���� 0 index26_ltc_sync_channel  I  
 (integer)   J �QQ    ( i n t e g e r )G RSR l 6TUVT r  6WXW J  2YY Z[Z m  \\ �]] 
 A u d i o[ ^_^ m  "`` �aa 
 V i d e o_ bcb m  "%dd �ee  C a m e r ac fgf m  %(hh �ii  M I D Ig jkj m  (+ll �mm  M S Ck n��n m  +.oo �pp  M I D I   S y s E x��  X o      �� 0 index27_patch  U  
 (integer)   V �qq    ( i n t e g e r )S rsr l 7Ctuvt r  7Cwxw J  7?yy z{z m  7:|| �}} 
 A u d i o{ ~�~~ m  := ��� 
 V i d e o�~  x o      �}�} 0 index28_start_time  u   (real)   v ���    ( r e a l )s ��� l DP���� r  DP��� J  DL�� ��� m  DG�� ��� 
 A u d i o� ��|� m  GJ�� ��� 
 V i d e o�|  � o      �{�{ 0 index29_end_time  �   (real)   � ���    ( r e a l )� ��� l QZ���� r  QZ��� J  QV�� ��z� m  QT�� ��� 
 A u d i o�z  � o      �y�y 0 index30_loop_start_time  �   (real)   � ���    ( r e a l )� ��� l [d���� r  [d��� J  [`�� ��x� m  [^�� ��� 
 A u d i o�x  � o      �w�w 0 index31_loop_end_time  �   (real)   � ���    ( r e a l )� ��� l en���� r  en��� J  ej�� ��v� m  eh�� ��� 
 A u d i o�v  � o      �u�u 0 index32_loop_count  �  
 (integer)   � ���    ( i n t e g e r )� ��� l o{���� r  o{��� J  ow�� ��� m  or�� ��� 
 A u d i o� ��t� m  ru�� ��� 
 V i d e o�t  � o      �s�s 0 index33_infinite_loop  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l |����� r  |���� J  |��� ��r� m  |�� ��� 
 A u d i o�r  � o      �q�q 0 index34_guarantee_sync  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ������ r  ����� J  ���� ��p� m  ���� ��� 
 A u d i o�p  � o      �o�o 0 index35_integrated_fade  �   (constants)   � ���    ( c o n s t a n t s )� ��� l ������ r  ����� J  ���� ��n� m  ���� ���  F a d e�n  � o      �m�m 0 index36_fade_mode  �   (constants)   � ���    ( c o n s t a n t s )� ��� l ������ r  ����� J  ���� ��� m  ���� ���  F a d e� ��l� m  ���� ���  A n i m a t i o n�l  � o      �k�k !0 index37_stop_target_when_done  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ������ r  ��� � J  �� �j m  �� � 
 V i d e o�j    o      �i�i 0 index38_auto_stop  �  
 (boolean)   � �    ( b o o l e a n )�  l ��	
 r  �� J  ��  m  �� � 
 V i d e o �h m  �� �  C a m e r a�h   o      �g�g 0 index39_layer  	  
 (integer)   
 �    ( i n t e g e r )  l �� r  �� J  ��  m  ��   �!! 
 V i d e o "�f" m  ��## �$$  C a m e r a�f   o      �e�e 0 index40_full_screen    
 (boolean)    �%%    ( b o o l e a n ) &'& l ��()*( r  ��+,+ J  ��-- ./. m  ��00 �11 
 V i d e o/ 2�d2 m  ��33 �44  C a m e r a�d  , o      �c�c !0 index41_preserve_aspect_ratio  )  
 (boolean)   * �55    ( b o o l e a n )' 676 l ��89:8 r  ��;<; J  ��== >?> m  ��@@ �AA 
 V i d e o? BCB m  ��DD �EE  A n i m a t i o nC F�bF m  ��GG �HH  C a m e r a�b  < o      �a�a 0 index42_opacity  9   (real)   : �II    ( r e a l )7 JKJ l ��LMNL r  ��OPO J  ��QQ RSR m  ��TT �UU 
 V i d e oS VWV m  ��XX �YY  A n i m a t i o nW Z�`Z m  ��[[ �\\  C a m e r a�`  P o      �_�_ 0 index43_translation_x  M   (real)   N �]]    ( r e a l )K ^_^ l �`ab` r  �cdc J  �ee fgf m  ��hh �ii 
 V i d e og jkj m  ��ll �mm  A n i m a t i o nk n�^n m  �oo �pp  C a m e r a�^  d o      �]�] 0 index44_translation_y  a   (real)   b �qq    ( r e a l )_ rsr l tuvt r  wxw J  yy z{z m  || �}} 
 V i d e o{ ~~ m  �� ���  A n i m a t i o n ��\� m  �� ���  C a m e r a�\  x o      �[�[ 0 index45_rotation  u   (real)   v ���    ( r e a l )s ��� l '���� r  '��� J  #�� ��� m  �� ��� 
 V i d e o� ��� m  �� ���  A n i m a t i o n� ��Z� m  !�� ���  C a m e r a�Z  � o      �Y�Y 0 index46_scale_x  �   (real)   � ���    ( r e a l )� ��� l (7���� r  (7��� J  (3�� ��� m  (+�� ��� 
 V i d e o� ��� m  +.�� ���  A n i m a t i o n� ��X� m  .1�� ���  C a m e r a�X  � o      �W�W 0 index47_scale_y  �   (real)   � ���    ( r e a l )� ��� l 8G���� r  8G��� J  8C�� ��� m  8;�� ��� 
 V i d e o� ��� m  ;>�� ���  A n i m a t i o n� ��V� m  >A�� ���  C a m e r a�V  � o      �U�U 0 index48_scale_locked  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l HT���� r  HT��� J  HP�� ��� m  HK�� ��� 
 V i d e o� ��T� m  KN�� ���  C a m e r a�T  � o      �S�S 0 index49_custom_rendering  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l U^���� r  U^��� J  UZ�� ��R� m  UX�� ���  A n i m a t i o n�R  � o      �Q�Q 0 index50_do_opacity  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l _h���� r  _h��� J  _d�� ��P� m  _b�� ���  A n i m a t i o n�P  � o      �O�O 0 index51_do_translation  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ir���� r  ir��� J  in�� ��N� m  il�� ���  A n i m a t i o n�N  � o      �M�M 0 index52_do_rotation  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l s|���� r  s|��� J  sx�� ��L� m  sv�� �    A n i m a t i o n�L  � o      �K�K 0 index53_do_scale  �  
 (boolean)   � �    ( b o o l e a n )�  l }� r  }� J  }�		 
�J
 m  }� �  M I D I�J   o      �I�I 0 index54_command     (constants)    �    ( c o n s t a n t s )  l �� r  �� J  �� �H m  �� �  M I D I�H   o      �G�G 0 index55_channel    
 (integer)    �    ( i n t e g e r )  l �� r  ��  J  ��!! "�F" m  ��## �$$  M I D I�F    o      �E�E 0 index56_byte_one    
 (integer)    �%%    ( i n t e g e r ) &'& l ��()*( r  ��+,+ J  ��-- .�D. m  ��// �00  M I D I�D  , o      �C�C 0 index57_byte_two  )  
 (integer)   * �11    ( i n t e g e r )' 232 l ��4564 r  ��787 J  ��99 :�B: m  ��;; �<<  M I D I�B  8 o      �A�A 0 index58_byte_combo  5  
 (integer)   6 �==    ( i n t e g e r )3 >?> l ��@AB@ r  ��CDC J  ��EE F�@F m  ��GG �HH  M I D I�@  D o      �?�? 0 index59_end_value  A  
 (integer)   B �II    ( i n t e g e r )? JKJ l ��LMNL r  ��OPO J  ��QQ R�>R m  ��SS �TT  M I D I�>  P o      �=�= 0 index60_fade  M   (constants)   N �UU    ( c o n s t a n t s )K VWV l ��XYZX r  ��[\[ J  ��]] ^�<^ m  ��__ �``  M S C�<  \ o      �;�; 0 index61_command_format  Y #  (integer - with translation)   Z �aa :   ( i n t e g e r   -   w i t h   t r a n s l a t i o n )W bcb l ��defd r  ��ghg J  ��ii j�:j m  ��kk �ll  M S C�:  h o      �9�9 0 index62_command_number  e #  (integer - with translation)   f �mm :   ( i n t e g e r   -   w i t h   t r a n s l a t i o n )c non l ��pqrp r  ��sts J  ��uu v�8v m  ��ww �xx  M S C�8  t o      �7�7 0 index63_q__number  q   (text)   r �yy    ( t e x t )o z{z l ��|}~| r  ��� J  ���� ��6� m  ���� ���  M S C�6  � o      �5�5 0 index64_q__list  }   (text)   ~ ���    ( t e x t ){ ��� l ������ r  ����� J  ���� ��4� m  ���� ���  M S C�4  � o      �3�3 0 index65_q__path  �   (text)   � ���    ( t e x t )� ��� l ������ r  ����� J  ���� ��2� m  ���� ���  M S C�2  � o      �1�1 0 index66_macro  �  
 (integer)   � ���    ( i n t e g e r )� ��� l ����� r  ���� J  ��� ��0� m  ��� ���  M S C�0  � o      �/�/ 0 index67_control_number  �  
 (integer)   � ���    ( i n t e g e r )� ��� l 	���� r  	��� J  	�� ��.� m  	�� ���  M S C�.  � o      �-�- 0 index68_control_value  �  
 (integer)   � ���    ( i n t e g e r )� ��� l ���� r  ��� J  �� ��,� m  �� ���  M S C�,  � o      �+�+ 0 index69_hours  �  
 (integer)   � ���    ( i n t e g e r )� ��� l &���� r  &��� J  "�� ��*� m   �� ���  M S C�*  � o      �)�) 0 index70_minutes  �  
 (integer)   � ���    ( i n t e g e r )� ��� l '0���� r  '0��� J  ',�� ��(� m  '*�� ���  M S C�(  � o      �'�' 0 index71_seconds  �  
 (integer)   � ���    ( i n t e g e r )� ��� l 1:���� r  1:��� J  16�� ��&� m  14�� ���  M S C�&  � o      �%�% 0 index72_frames  �  
 (integer)   � ���    ( i n t e g e r )� ��� l ;D���� r  ;D��� J  ;@�� ��$� m  ;>�� ���  M S C�$  � o      �#�# 0 index73_subframes  �  
 (integer)   � ���    ( i n t e g e r )� ��� l EN���� r  EN��� J  EJ�� ��"� m  EH�� ���  M S C�"  � o      �!�! 0 index74_send_time_with_set  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l OX   r  OX J  OT �  m  OR �  M I D I   S y s E x�    o      �� 0 index75_sysex_message     (text)    �		    ( t e x t )� 

 l Yb r  Yb J  Y^ � m  Y\ �  M T C�   o      �� 0 index76_midi_destination     (text)    �    ( t e x t )  l cl r  cl J  ch � m  cf �    M T C�   o      �� 0 index77_start_time_offset     (real)    �!!    ( r e a l ) "#" l mv$%&$ r  mv'(' J  mr)) *�* m  mp++ �,,  D e v a m p�  ( o      �� (0 $index78_fire_next_cue_when_loop_ends  %  
 (boolean)   & �--    ( b o o l e a n )# ./. l w�0120 r  w�343 J  w|55 6�6 m  wz77 �88  D e v a m p�  4 o      �� &0 "index79_stop_target_when_loop_ends  1  
 (boolean)   2 �99    ( b o o l e a n )/ :;: l ��<=>< r  ��?@? J  ��AA B�B m  ��CC �DD  L o a d�  @ o      �� 0 index80_load_time  =   (real)   > �EE    ( r e a l ); FGF l ��HIJH r  ��KLK J  ��MM N�N m  ��OO �PP  T a r g e t�  L o      �� 0 index81_assigned_number  I   (text)   J �QQ    ( t e x t )G RSR l     ����  �  �  S TUT l ��VWXV r  ��YZY J  ��[[ \]\ m  ��^^ �__ 
 A u d i o] `a` m  ��bb �cc  F a d ea d�d m  ��ee �ff 
 V i d e o�  Z o      ��  0 index_setlevel index_setLevelW 6 0 Special private index for custom column headers   X �gg `   S p e c i a l   p r i v a t e   i n d e x   f o r   c u s t o m   c o l u m n   h e a d e r sU hih l     ����  �  �  i jkj l     �
lm�
  l x r This is a list of values for any constants (which can be used to customise the entries required in the text file)   m �nn �   T h i s   i s   a   l i s t   o f   v a l u e s   f o r   a n y   c o n s t a n t s   ( w h i c h   c a n   b e   u s e d   t o   c u s t o m i s e   t h e   e n t r i e s   r e q u i r e d   i n   t h e   t e x t   f i l e )k opo l     �	���	  �  �  p qrq l ��s��s r  ��tut J  ��vv wxw m  ��yy �zz  d o _ n o t _ c o n t i n u ex {|{ m  ��}} �~~  a u t o _ c o n t i n u e| � m  ���� ���  a u t o _ f o l l o w�  u o      �� 0 constants10_continue_mode  �  �  r ��� l ������ r  ����� J  ���� ��� m  ���� ���  t r u e� �� � m  ���� ��� 
 f a l s e�   � o      ���� 0 constants11_armed  �  �  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  e n a b l e d� ���� m  ���� ���  d i s a b l e d��  � o      ���� 0 constants12_midi_trigger  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  n o t e _ o n� ��� m  ���� ���  n o t e _ o f f� ��� m  ���� ���  p r o g r a m _ c h a n g e� ��� m  ���� ���  c o n t r o l _ c h a n g e� ��� m  ���� ���  k e y _ p r e s s u r e� ���� m  ���� ���   c h a n n e l _ p r e s s u r e��  � o      ���� 0 constants13_midi_command  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  e n a b l e d� ���� m  ���� ���  d i s a b l e d��  � o      ����  0 constants16_timecode_trigger  ��  ��  � ��� l ������� r  ���� J  ���� ��� m  ���� ���  e n a b l e d� ���� m  ���� ���  d i s a b l e d��  � o      ���� "0 constants17_wall_clock_trigger  ��  ��  � ��� l ������ r  ��� J  �� ��� m  �� ���  c u e _ l i s t� ��� m  
�� ��� , f i r e _ f i r s t _ e n t e r _ g r o u p� ��� m  
�� ��� 2 f i r e _ f i r s t _ g o _ t o _ n e x t _ c u e� ��� m  �� ���  f i r e _ a l l� ���� m  �� ���  f i r e _ r a n d o m��  � o      ���� 0 constants21_mode  ��  ��  � ��� l (������ r  (��� J  $�� ��� m  �� ���  e n a b l e d� ���� m  "�� ���  d i s a b l e d��  � o      ����  0 constants22_sync_to_timecode  ��  ��  � ��� l )5������ r  )5��� J  )1�� � � m  ), �  m t c  �� m  ,/ �  l t c��  � o      ���� 0 constants23_sync_mode  ��  ��  �  l 6J���� r  6J	
	 J  6F  m  69 �  f p s _ 2 4  m  9< �  f p s _ 2 5  m  <? �  f p s _ 3 0 _ d r o p �� m  ?B �  f p s _ 3 0 _ n o n _ d r o p��  
 o      ���� 0 constants24_smpte_format  ��  ��    l KW���� r  KW J  KS   !"! m  KN## �$$  t r u e" %��% m  NQ&& �'' 
 f a l s e��   o      ���� 0 constants33_infinite_loop  ��  ��   ()( l Xd*����* r  Xd+,+ J  X`-- ./. m  X[00 �11  t r u e/ 2��2 m  [^33 �44 
 f a l s e��  , o      ���� 0 constants34_guarantee_sync  ��  ��  ) 565 l eq7����7 r  eq898 J  em:: ;<; m  eh== �>>  e n a b l e d< ?��? m  hk@@ �AA  d i s a b l e d��  9 o      ���� 0 constants35_integrated_fade  ��  ��  6 BCB l r~D����D r  r~EFE J  rzGG HIH m  ruJJ �KK  a b s o l u t eI L��L m  uxMM �NN  r e l a t i v e��  F o      ���� 0 constants36_fade_mode  ��  ��  C OPO l �Q����Q r  �RSR J  �TT UVU m  �WW �XX  t r u eV Y��Y m  ��ZZ �[[ 
 f a l s e��  S o      ���� %0 !constants37_stop_target_when_done  ��  ��  P \]\ l ��^����^ r  ��_`_ J  ��aa bcb m  ��dd �ee  t r u ec f��f m  ��gg �hh 
 f a l s e��  ` o      ���� 0 constants38_auto_stop  ��  ��  ] iji l ��k����k r  ��lml J  ��nn opo m  ��qq �rr  t r u ep s��s m  ��tt �uu 
 f a l s e��  m o      ���� 0 constants40_full_screen  ��  ��  j vwv l ��x����x r  ��yzy J  ��{{ |}| m  ��~~ �  t r u e} ���� m  ���� ��� 
 f a l s e��  z o      ���� %0 !constants41_preserve_aspect_ratio  ��  ��  w ��� l �������� r  ����� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ���� 0 constants48_scale_locked  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ����  0 constants49_custom_rendering  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ���� 0 constants50_do_opacity  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ���� 0 constants51_do_translation  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ���� 0 constants52_do_rotation  ��  ��  � ��� l � ������ r  � ��� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ���� 0 constants53_do_scale  ��  ��  � ��� l ������ r  ��� J  �� ��� m  �� ���  n o t e _ o n� ��� m  �� ���  n o t e _ o f f� ��� m  
�� ���  p r o g r a m _ c h a n g e� ��� m  
�� ���  c o n t r o l _ c h a n g e� ��� m  �� ���  k e y _ p r e s s u r e� ��� m  �� ���   c h a n n e l _ p r e s s u r e� ���� m  �� ���  p i t c h _ b e n d��  � o      ���� 0 constants54_command  ��  ��  � ��� l +������ r  +��� J  '�� ��� m  "�� ���  e n a b l e d� ���� m  "%�� ���  d i s a b l e d��  � o      ���� 0 constants60_fade  ��  ��  � � � l ,8���� r  ,8 J  ,4  m  ,/ �  t r u e 	��	 m  /2

 � 
 f a l s e��   o      ���� "0 constants74_send_time_with_set  ��  ��     l 9E���� r  9E J  9A  m  9< �  t r u e �� m  <? � 
 f a l s e��   o      ���� ,0 (constants78_fire_next_cue_when_loop_ends  ��  ��    l FR���� r  FR J  FN   m  FI!! �""  t r u e  #��# m  IL$$ �%% 
 f a l s e��   o      ���� *0 &constants79_stop_target_when_loop_ends  ��  ��   &'& l     ��������  ��  ��  ' ()( l     ��*+��  * F @ These variables are used to translate MSC integers into English   + �,, �   T h e s e   v a r i a b l e s   a r e   u s e d   t o   t r a n s l a t e   M S C   i n t e g e r s   i n t o   E n g l i s h) -.- l     ��������  ��  ��  . /0/ l S�1����1 r  S�232 J  S�44 565 m  SV77 �88  16 9:9 m  VY;; �<< $ L i g h t i n g   ( G e n e r a l ): =>= m  Y\?? �@@  2> ABA m  \_CC �DD  M o v i n g   L i g h t sB EFE m  _bGG �HH  3F IJI m  beKK �LL  C o l o r   C h a n g e r sJ MNM m  ehOO �PP  4N QRQ m  hkSS �TT  S t r o b e sR UVU m  knWW �XX  5V YZY m  nq[[ �\\  L a s e r sZ ]^] m  qt__ �``  6^ aba m  twcc �dd  C h a s e r sb efe l 	wzg����g m  wzhh �ii  1 6��  ��  f jkj m  z}ll �mm  S o u n d   ( G e n e r a l )k non m  }�pp �qq  1 7o rsr m  ��tt �uu 
 M u s i cs vwv m  ��xx �yy  1 8w z{z m  ��|| �}}  C D   P l a y e r s{ ~~ m  ���� ���  1 9 ��� m  ���� ���  E P R O M   P l a y b a c k� ��� m  ���� ���  2 0� ��� m  ���� ��� & A u d i o   T a p e   M a c h i n e s� ��� m  ���� ���  2 1� ��� m  ���� ���  I n t e r c o m s� ��� m  ���� ���  2 2� ��� m  ���� ���  A m p l i f i e r s� ��� l 	�������� m  ���� ���  2 3��  ��  � ��� m  ���� ��� * A u d i o   E f f e c t s   D e v i c e s� ��� m  ���� ���  2 4� ��� m  ���� ���  E q u a l i z e r s� ��� m  ���� ���  3 2� ��� m  ���� ��� & M a c h i n e r y   ( G e n e r a l )� ��� m  ���� ���  3 3� ��� m  ���� ���  R i g g i n g� ��� m  ���� ���  3 4� ��� m  ���� ���  F l y s� ��� m  ���� ���  3 5� ��� m  ���� ��� 
 L i f t s� ��� m  ���� ���  3 6� ��� m  ���� ���  T u r n t a b l e s� ��� m  ���� ���  3 7� ��� m  ���� ���  T r u s s e s� ��� l 	�������� m  ���� ���  3 8��  ��  � ��� m  ���� ���  R o b o t s� ��� m  ���� ���  3 9� ��� m  ���� ���  A n i m a t i o n� ��� m  ���� ���  4 0� ��� m  ���� ���  F l o a t s� ��� m  ���� ���  4 1� ��� m  ���� ���  B r e a k a w a y s� 	 		  m  ��		 �		  4 2	 			 m  ��		 �		  B a r g e s	 				 m  ��	
	
 �		  4 8		 			 m  ��		 �		  V i d e o   ( G e n e r a l )	 			 m  ��		 �		  4 9	 			 m  ��		 �		 & V i d e o   T a p e   M a c h i n e s	 			 l 	��	����	 m  ��		 �		  5 0��  ��  	 			 m  �		 �	 	  . V i d e o   C a s s e t t e   M a c h i n e s	 	!	"	! m  	#	# �	$	$  5 1	" 	%	&	% m  	'	' �	(	( $ V i d e o   D i s c   P l a y e r s	& 	)	*	) m  
	+	+ �	,	,  5 2	* 	-	.	- m  
	/	/ �	0	0  V i d e o   S w i t c h e r s	. 	1	2	1 m  	3	3 �	4	4  5 3	2 	5	6	5 m  	7	7 �	8	8  V i d e o   E f f e c t s	6 	9	:	9 m  	;	; �	<	<  5 4	: 	=	>	= m  	?	? �	@	@ 4 V i d e o   C h a r a c t e r   G e n e r a t o r s	> 	A	B	A l 		C����	C m  	D	D �	E	E  5 5��  ��  	B 	F	G	F m  	H	H �	I	I $ V i d e o   S t i l l   S t o r e s	G 	J	K	J m  "	L	L �	M	M  5 6	K 	N	O	N m  "%	P	P �	Q	Q  V i d e o   M o n i t o r s	O 	R	S	R m  %(	T	T �	U	U  6 4	S 	V	W	V m  (+	X	X �	Y	Y ( P r o j e c t i o n   ( G e n e r a l )	W 	Z	[	Z m  +.	\	\ �	]	]  6 5	[ 	^	_	^ m  .1	`	` �	a	a  F i l m   P r o j e c t o r s	_ 	b	c	b m  14	d	d �	e	e  6 6	c 	f	g	f m  47	h	h �	i	i   S l i d e   P r o j e c t o r s	g 	j	k	j m  7:	l	l �	m	m  6 7	k 	n	o	n m  :=	p	p �	q	q   V i d e o   P r o j e c t o r s	o 	r	s	r l 	=@	t��~	t m  =@	u	u �	v	v  6 8�  �~  	s 	w	x	w m  @C	y	y �	z	z  D i s s o l v e r s	x 	{	|	{ m  CF	}	} �	~	~  6 9	| 		�	 m  FI	�	� �	�	�   S h u t t e r   C o n t r o l s	� 	�	�	� m  IL	�	� �	�	�  8 0	� 	�	�	� m  LO	�	� �	�	� 2 P r o c e s s   C o n t r o l   ( G e n e r a l )	� 	�	�	� m  OR	�	� �	�	�  8 1	� 	�	�	� m  RU	�	� �	�	�  H y d r a u l i c   O i l	� 	�	�	� m  UX	�	� �	�	�  8 2	� 	�	�	� m  X[	�	� �	�	�  H 2 O	� 	�	�	� m  [^	�	� �	�	�  8 3	� 	�	�	� m  ^a	�	� �	�	�  C O 2	� 	�	�	� m  ad	�	� �	�	�  8 4	� 	�	�	� m  dg	�	� �	�	�  C o m p r e s s e d   A i r	� 	�	�	� l 	gj	��}�|	� m  gj	�	� �	�	�  8 5�}  �|  	� 	�	�	� m  jm	�	� �	�	�  N a t u r a l   G a s	� 	�	�	� m  mp	�	� �	�	�  8 6	� 	�	�	� m  ps	�	� �	�	�  F o g	� 	�	�	� m  sv	�	� �	�	�  8 7	� 	�	�	� m  vy	�	� �	�	� 
 S m o k e	� 	�	�	� m  y|	�	� �	�	�  8 8	� 	�	�	� m  |	�	� �	�	�  C r a c k e d   H a z e	� 	�	�	� m  �	�	� �	�	�  9 6	� 	�	�	� m  ��	�	� �	�	� , P y r o t e c h n i c s   ( G e n e r a l )	� 	�	�	� m  ��	�	� �	�	�  9 7	� 	�	�	� m  ��	�	� �	�	�  F i r e w o r k s	� 	�	�	� m  ��	�	� �	�	�  9 8	� 	�	�	� m  ��	�	� �	�	�  E x p l o s i o n s	� 	�	�	� m  ��	�	� �	�	�  9 9	� 	�	�	� m  ��	�	� �	�	� 
 F l a m e	� 	�	�	� l 	��	��{�z	� m  ��	�	� �	�	�  1 0 0�{  �z  	� 	�	�	� m  ��	�	� �	�	�  S m o k e   P o t s	� 	�	�	� m  ��	�	� �	�	�  1 2 7	� 	��y	� m  ��	�	� �	�	�  A l l   T y p e s�y  3 o      �x�x  0 translation61_command_format  ��  ��  0 	�	�	� l �P	��w�v	� r  �P	�
 	� J  �L

 


 m  ��

 �

  1
 


 m  ��

 �
	
	  G O
 




 m  ��

 �

  2
 


 m  ��

 �

  S T O P
 


 m  ��

 �

  3
 


 m  ��

 �

  R E S U M E
 


 m  ��

 �

  4
 


 m  ��
 
  �
!
!  T I M E D _ G O
 
"
#
" m  ��
$
$ �
%
%  5
# 
&
'
& m  ��
(
( �
)
)  L O A D
' 
*
+
* m  ��
,
, �
-
-  6
+ 
.
/
. m  ��
0
0 �
1
1  S E T
/ 
2
3
2 m  ��
4
4 �
5
5  7
3 
6
7
6 m  ��
8
8 �
9
9  F I R E
7 
:
;
: m  ��
<
< �
=
=  8
; 
>
?
> m  ��
@
@ �
A
A  A L L _ O F F
? 
B
C
B l 	��
D�u�t
D m  ��
E
E �
F
F  9�u  �t  
C 
G
H
G m  ��
I
I �
J
J  R E S T O R E
H 
K
L
K m  ��
M
M �
N
N  1 0
L 
O
P
O m  ��
Q
Q �
R
R 
 R E S E T
P 
S
T
S m  ��
U
U �
V
V  1 1
T 
W
X
W m  ��
Y
Y �
Z
Z  G O _ O F F
X 
[
\
[ m  ��
]
] �
^
^  1 6
\ 
_
`
_ m  ��
a
a �
b
b  G O / J A M _ C L O C K
` 
c
d
c m  ��
e
e �
f
f  1 7
d 
g
h
g m  ��
i
i �
j
j  S T A N D B Y _ +
h 
k
l
k m  ��
m
m �
n
n  1 8
l 
o
p
o m  � 
q
q �
r
r  S T A N D B Y _ -
p 
s
t
s m   
u
u �
v
v  1 9
t 
w
x
w m  
y
y �
z
z  S E Q U E N C E _ +
x 
{
|
{ l 		
}�s�r
} m  	
~
~ �

  2 0�s  �r  
| 
�
�
� m  	
�
� �
�
�  S E Q U E N C E _ -
� 
�
�
� m  
�
� �
�
�  2 1
� 
�
�
� m  
�
� �
�
�  S T A R T _ C L O C K
� 
�
�
� m  
�
� �
�
�  2 2
� 
�
�
� m  
�
� �
�
�  S T O P _ C L O C K
� 
�
�
� m  
�
� �
�
�  2 3
� 
�
�
� m  
�
� �
�
�  Z E R O _ C L O C K
� 
�
�
� m  !
�
� �
�
�  2 4
� 
�
�
� m  !$
�
� �
�
�  S E T _ C L O C K
� 
�
�
� m  $'
�
� �
�
�  2 5
� 
�
�
� m  '*
�
� �
�
�  M T C _ C H A S E _ O N
� 
�
�
� l 	*-
��q�p
� m  *-
�
� �
�
�  2 6�q  �p  
� 
�
�
� m  -0
�
� �
�
�  M T C _ C H A S E _ O F F
� 
�
�
� m  03
�
� �
�
�  2 7
� 
�
�
� m  36
�
� �
�
�  O P E N _ C U E _ L I S T
� 
�
�
� m  69
�
� �
�
�  2 8
� 
�
�
� m  9<
�
� �
�
�  C L O S E _ C U E _ L I S T
� 
�
�
� m  <?
�
� �
�
�  2 9
� 
�
�
� m  ?B
�
� �
�
�  O P E N _ C U E _ P A T H
� 
�
�
� m  BE
�
� �
�
�  3 0
� 
��o
� m  EH
�
� �
�
�  C L O S E _ C U E _ P A T H�o  
  o      �n�n  0 translation62_command_number  �w  �v  	� 
�
�
� l     �m�l�k�m  �l  �k  
� 
�
�
� l     �j
�
��j  
�   General variables   
� �
�
� $   G e n e r a l   v a r i a b l e s
� 
�
�
� l     �i�h�g�i  �h  �g  
� 
�
�
� l QW
��f�e
� r  QW
�
�
� J  QS�d�d  
� o      �c�c *0 propertiestocolumns propertiesToColumns�f  �e  
� 
�
�
� l X_
��b�a
� r  X_
�
�
� m  X[
�
� �
�
�  N o
� o      �`�` &0 annotateeveryline annotateEveryLine�b  �a  
� 
�
�
� l `f
��_�^
� r  `f
�
�
� J  `b�]�]  
� o      �\�\ 0 
cuestomove 
cuesToMove�_  �^  
� 
�
�
� l     �[�Z�Y�[  �Z  �Y  
� 
�
�
� l g3Y
��X�W
� Q  g3Y
�
�
�
� l j3L
�
�
�
� k  j3L
�
� 
�
�
� l jj�V�U�T�V  �U  �T  
� 
�
�
� l jj�S
�
��S  
�  	 Preamble   
� �      P r e a m b l e
�  l jj�R�Q�P�R  �Q  �P    r  jq m  jm � & R e v i e w   i n s t r u c t i o n s o      �O�O 0 thenavigator theNavigator 	
	 W  r
= k  ~
8  r  ~� n  ~� 1  ���N
�N 
bhit l ~��M�L I ~��K
�K .sysodlogaskr        TEXT m  ~� � t W o u l d   y o u   l i k e   t o   r e v i e w   t h e   i n s t r u c t i o n s   f o r   t h i s   s c r i p t ? �J
�J 
appr l 	���I�H o  ���G�G 0 dialogtitle dialogTitle�I  �H   �F
�F 
disp m  ���E�E  �D
�D 
btns J  ��   !"! m  ��## �$$ & R e v i e w   i n s t r u c t i o n s" %&% m  ��'' �((  C a n c e l& )�C) m  ��** �++  G e t   o n   w i t h   i t�C   �B,-
�B 
dflt, m  ��.. �//  G e t   o n   w i t h   i t- �A0�@
�A 
cbtn0 m  ��11 �22  C a n c e l�@  �M  �L   o      �?�? 0 thenavigator theNavigator 343 Z  �
656�>�=5 = ��787 o  ���<�< 0 thenavigator theNavigator8 m  ��99 �:: & R e v i e w   i n s t r u c t i o n s6 k  �
2;; <=< r  ��>?> m  ���;
�; boovfals? o      �:�: "0 finishedreading finishedReading= @�9@ W  �
2ABA k  �
-CC DED r  ��FGF m  ��HH �II 2 C o p y   h e a d e r s   t o   C l i p b o a r dG o      �8�8 (0 instructionbutton1 instructionButton1E JKJ W  �	kLML k  �	fNN OPO r  �	=QRQ n  �	9STS 1  	5	9�7
�7 
bhitT l �	5U�6�5U I �	5�4VW
�4 .sysodlogaskr        TEXTV b  �	XYX b  �	Z[Z b  �	\]\ b  �	^_^ b  �	`a` b  ��bcb b  ��ded b  ��fgf b  ��hih b  ��jkj b  ��lml b  ��non m  ��pp �qq x T h i s   s c r i p t   w i l l   t a k e   a   t a b - d e l i m i t e d   t e x t   f i l e   a n d   a t t e m p t  o l 	��r�3�2r m  ��ss �ttV t o   t u r n   i t   i n t o   a   s e t   o f   c u e s   i n   Q L a b ' s   c u r r e n t   c u e   l i s t . 
   
 A l t h o u g h   i t   i s   r e l a t i v e l y   n o n - p r e s c r i p t i v e   i n   i t s   a p p r o a c h ,   t h e   s c r i p t   d o e s   a s k   a   f e w   t h i n g s : 
   
 1 .   T h e   f i r s t   r o w   o f   t h e   t e x t   f i l e   m u s t   c o n t a i n   t h e   " c o l u m n   h e a d e r s " ,   i e :   i t   s h o u l d   d e f i n e   w h i c h   p r o p e r t i e s   y o u   a r e   h o p i n g   t o   s e t   i n   y o u r   c u e s .  �3  �2  m l 	��u�1�0u m  ��vv �ww U n l e s s   y o u   c u s t o m i s e   t h e   s c r i p t   ( l o o k   i n s i d e   i t   t o   f i n d   o u t   m o r e   a b o u t   t h a t ) ,   t h e s e   c o l u m n   h e a d e r s   m u s t   e x a c t l y   m a t c h   t h e   s t r i n g s  �1  �0  k l 	��x�/�.x m  ��yy �zz u s e d   i n   Q L a b ' s   A p p l e S c r i p t   d i c t i o n a r y .   F o r   a   l i s t   y o u   c a n   l o o k   a t   t h e   d i c t i o n a r y ,   s e e   t h e   " s e t   a c c e p t a b l e C o l u m n H e a d e r s "   l i n e   i n s i d e  �/  �.  i l 	��{�-�,{ m  ��|| �}}\ t h i s   s c r i p t ,   o r   p u s h   t h e   b u t t o n   b e l o w   t o   c o p y   i t   t o   t h e   C l i p b o a r d   ( a s   a   t a b - d e l i m i t e d   r o w ) . 
   
 2 .   Y o u   h a v e   t o   h a v e   a   " t y p e "   c o l u m n   t o   t e l l   t h e   s c r i p t   w h a t   t o   m a k e ! 
   
 3 .   E n t r i e s   i n   t h e   " c e l l s "   s h o u l d   a l s o   c o n f o r m   t o   Q L a b ' s   A p p l e S c r i p t   e x p e c t a t i o n s ,   e g :   " d o _ n o t _ c o n t i n u e " ,   " a u t o _ c o n t i n u e "   &   " a u t o _ f o l l o w "  �-  �,  g l 	��~�+�*~ m  �� ��� � f o r   " c o n t i n u e   m o d e " ;   a g a i n ,   t h e s e   a r e   c u s t o m i s a b l e   a t   s c r i p t   l e v e l .   A n   e x c e p t i o n   t o   t h i s   i s   t h a t   M S C   c o m m a n d   f o r m a t s   &   n u m b e r s  �+  �*  e l 	����)�(� m  ���� ���� s h o u l d   b e   e x p r e s s e d   a s   t h e   t e x t   y o u   s e e   i n   t h e   I n s p e c t o r ,   n o t   a s   t h e   i n t e g e r s   t h a t   A p p l e S c r i p t   d e a l s   w i t h . 
   
 T h e   s c r i p t   w i l l   m a k e   a n y   k i n d   o f   c u e   ( e x c e p t   C u e   L i s t s :   t o o   c o m p l i c a t e d ;   m a k e   a   G r o u p   C u e   i n s t e a d   a n d   m o v e   i t   l a t e r )   a n d   s e t   a n y   k i n d   o f   p r o p e r t y  �)  �(  c l 	����'�&� m  ���� ��� � c u r r e n t l y   d e f i n e d   i n   t h e   A p p l e S c r i p t   h o o k s .   F i l e   t a r g e t s   w o r k   i f   y o u   p a s t e   t h e   f u l l   p a t h   i n   " P O S I X "   f o r m ,   i e :  �'  �&  a l 	�	��%�$� m  �	�� ��� � " / S y s t e m / L i b r a r y / S o u n d s / B a s s o . a i f f " .   O p t i o n a l l y ,   i f   a l l   y o u r   m e d i a   f i l e s   s h a r e   a   c o m m o n   r o o t   p a t h ,   y o u   c a n   c h o o s e   t h i s   f o l d e r  �%  �$  _ l 			��#�"� m  		�� ��� a n d   t h e   s c r i p t   w i l l   a d d   t h i s   t o   t h e   f i l e   t a r g e t s   -   s a v i n g   y o u   a   b i t   o f   t y p i n g .   S i n c e   a   f i l e   t a r g e t   c o l u m n   i s   p r o c e s s e d   b e f o r e   m o s t  �#  �"  ] l 			
��!� � m  		
�� ���V o t h e r   c o l u m n s   ( r e g a r d l e s s   o f   t h e   o r d e r   i n   t h e   t e x t   f i l e ) ,   y o u   d o n ' t   n e e d   t o   w o r r y   a b o u t   s e t t i n g s   b e i n g   r e s e t   w h e n   a   f i l e   t a r g e t   c h a n g e s . . . 
   
 O n e   o b v i o u s ,   b u t   s i g n i f i c a n t ,   l i m i t i n g   f a c t o r   i s   t h a t   y o u   c a n ' t   o f   c o u r s e   t a r g e t   c u e s   t h a t   d o n ' t   e x i s t   y e t   -   s i n c e   t h e   s c r i p t   t r u n d l e s   t h r o u g h   y o u r   t e x t   f i l e  �!  �   [ l 			���� m  		�� ��� � i n   a   l i n e a r   w a y ,   m a k i n g   c u e s   a s   i t   g o e s ,   i f   Q 3   i s   s u p p o s e d   t o   a r m   Q 4   t h a t   w o n ' t   w o r k   b e c a u s e   Q 4   h a s n ' t   b e e n   m a d e   y e t  �  �  Y l 			���� m  		�� ��� � w h e n   Q 3   i s   m a d e .   C l e a r ? 
   
 T h e   n e x t   p a g e   h a s   s o m e   d e t a i l s   a b o u t   e r r o r   p r o t e c t i o n ,   g r o u p s   a n d   l e v e l s . . .�  �  W ���
� 
appr� o  		�� 0 dialogtitle dialogTitle� ���
� 
disp� l 
		���� m  		�� �  �  � ���
� 
btns� J  		)�� ��� m  		!�� ���  B a c k   t o   s t a r t� ��� m  	!	$�� ��� 2 C o p y   h e a d e r s   t o   C l i p b o a r d� ��� m  	$	'�� ���  T o   p a g e   2   > > >�  � ���
� 
dflt� m  	,	/�� ���  T o   p a g e   2   > > >�  �6  �5  R o      �� (0 instructionbutton1 instructionButton1P ��� Z  	>	f����� = 	>	E��� o  	>	A�� (0 instructionbutton1 instructionButton1� m  	A	D�� ��� 2 C o p y   h e a d e r s   t o   C l i p b o a r d� n 	H	P��� I  	I	P����  0 totheclipboard toTheClipboard� ��� o  	I	L�
�
 20 acceptablecolumnheaders acceptableColumnHeaders�  �  �  f  	H	I� ��� = 	S	Z��� o  	S	V�	�	 (0 instructionbutton1 instructionButton1� m  	V	Y�� ���  B a c k   t o   s t a r t� ��� r  	]	b��� m  	]	^�
� boovtrue� o      �� "0 finishedreading finishedReading�  �  �  M > ����� o  ���� (0 instructionbutton1 instructionButton1� m  ���� ��� 2 C o p y   h e a d e r s   t o   C l i p b o a r dK ��� Z  	l
-����� = 	l	s��� o  	l	o�� (0 instructionbutton1 instructionButton1� m  	o	r�� ���  T o   p a g e   2   > > >� k  	v
)�� ��� r  	v	}��� m  	v	y�� ��� 2 C o p y   h e a d e r s   t o   C l i p b o a r d� o      � �  (0 instructionbutton2 instructionButton2� ���� W  	~
)��� k  	�
$�� ��� r  	�	���� n  	�	���� 1  	�	���
�� 
bhit� l 	�	������� I 	�	�����
�� .sysodlogaskr        TEXT� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	���� b  	�	�   m  	�	� � v T h e r e ' s   n o t   a   l o t   o f   p r o t e c t i o n   a g a i n s t   y o u   g e t t i n g   t h i n g s   l 		�	����� m  	�	� � � i n   y o u r   f i l e   w r o n g ;   t h e r e   a r e   n o   d o u b t   h u n d r e d s   o f   w a y s   y o u   c a n   f i n d   t o   b r e a k   t h e   s c r i p t .   T h e r e   i s   a   b a s i c   e r r o r   f l a g :   " ! ! ! ! "  ��  ��  � l 		�	����� m  	�	� �		 � w i l l   b e   p r e p e n d e d   t o   t h e   q   n a m e   o f   a n y   c u e   w h e n   a   p r o c e s s   i n v o l v e d   i n   m a k i n g   t h e   c u e   w e n t   w r o n g ;   t h e   l i n e   u s e d   t o   m a k e   t h e  ��  ��  � l 		�	�
����
 m  	�	� � � c u e   w i l l   b e   c o p i e d   t o   t h e   c u e ' s   n o t e s   f o r   r e f e r e n c e :   i t ' s   o v e r   t o   y o u   t o   f i g u r e   i t   o u t   ( t r y i n g   t o   f l a g   w h a t   e x a c t l y   w e n t   w r o n g  ��  ��  � l 		�	����� m  	�	� �L i s   t o o   c o m p l i c a t e d ) . 
   
 T h e   s c r i p t   i s   c a p a b l e   o f   m o v i n g   c u e s   i n t o   g r o u p s   w h e n   i t ' s   f i n i s h e d   m a k i n g   t h e m   a l l :   a d d   a   c o l u m n   c a l l e d   " p u t   i n   g r o u p "   a n d   e n t e r   t h e   q   n u m b e r  ��  ��  � l 		�	����� m  	�	� � � o f   t h e   d e s t i n a t i o n   g r o u p   i n   t h a t   c e l l   f o r   t h e   c u e s   y o u   w i s h   t o   m o v e .   T h i s   o n l y   w o r k s   i f   y o u   h a v e   s e t   q   n u m b e r s   f o r   b o t h  ��  ��  � l 		�	����� m  	�	� �\ t h e   c u e   a n d   t h e   g r o u p . 
   
 I n   f a c t ,   q u i t e   a   l o t   o f   t h e   a c t i o n s   r e l y   o n   c u e s   h a v i n g   q   n u m b e r s   ( e g :   a n y t h i n g   t h a t   r e q u i r e s   s e t t i n g   a   c u e   t a r g e t ) .   T h e r e   a r e   p r o b a b l y   c o m p l e x   w a y s  ��  ��  � l 		�	����� m  	�	� � � r o u n d   t h i s ,   b u t   f o r   n o w   y o u ' l l   h a v e   t o   m a k e   d o   w i t h   u s i n g   q   n u m b e r s   f o r   m o s t   o f   t h e   c u e s   i n   t h e   t e x t   f i l e   a n d   t h e n   r e m o v i n g  ��  ��  � l 		�	����� m  	�	� � � t h o s e   y o u   d o n ' t   w a n t   f r o m   t h e   w o r k s p a c e .   Y o u   c a n   e n t e r t a i n   y o u r s e l f   w o r k i n g   o u t   w h e n   y o u   c a n   g e t   a w a y   w i t h o u t   a   q   n u m b e r !  ��  ��  � l 		�	����� m  	�	� � A l l   k i n d s   o f   e x c i t i n g   t h i n g s   c a n   g o   w r o n g   i f   a   q   n u m b e r   i s   m i s s i n g   o r   i n v a l i d   ( e g :   i f   y o u   m o v e   a   c u e   t o   a   g r o u p   t h a t   d o e s n ' t   e x i s t ,  ��  ��  � l 		�	����� m  	�	�   �!! t h e   c u e   v a n i s h e s . . . ) .   W a t c h   o u t   f o r   q   n u m b e r s   t h a t   a l r e a d y   e x i s t   i n   t h e   w o r k s p a c e   a s   t h e y   w i l l   b e   u n c e r e m o n i o u s l y   d r o p p e d . . .   
   
 S i n c e   t h e r e   a r e   c u r r e n t l y   8 3 3   p o s s i b l e   s c r i p t a b l e   l e v e l s   f o r   t h o s e   c u e s   t h a t   t a k e   t h e m ,   i t ' s   u p   t o   y o u   w h i c h   l e v e l s   t o   s e t   i n   y o u r   f i l e .  ��  ��  � l 		�	�"����" m  	�	�## �$$ � F o r   a n y   c r o s s p o i n t   y o u   w i s h   t o   s e t ,   a d d   a   c o l u m n   h e a d e r   o f   t h e   f o r m   " r o w , c o l u m n "   a n d   e n t e r   t h e   l e v e l s   i n   t h a t   c o l u m n .  ��  ��  � l 		�	�%����% m  	�	�&& �'' � F o r   e x a m p l e :   c o l u m n   h e a d e r   " 0 , 0 "   s p e c i f i e s   r o w   0   c o l u m n   0   ( i e :   t h e   M a s t e r   l e v e l ) ,   " 2 , 4 2 "   w o u l d   b e   r o w   2   c o l u m n   4 2  ��  ��  � l 		�	�(����( m  	�	�)) �** � ( t h e   c r o s s p o i n t   b e t w e e n   c h a n n e l   2   o f   y o u r   a u d i o   f i l e   a n d   o u t p u t   4 2 ) .   W a t c h   o u t   f o r   d e f a u l t   g a n g s   i n   y o u r   w o r k s p a c e ,  ��  ��  � l 		�	�+����+ m  	�	�,, �--� a s   t h e y ' l l   o v e r r i d e   a n y   a t t e m p t   t o   s e t   l e v e l s   i n d e p e n d e n t l y . 
   
 F o r   t h e   s a k e   o f   s i m p l i c i t y ,   i f   y o u   w a n t   " - I N F "   y o u ' l l   n e e d   t o   p u t   " - 1 2 0 "   i n   y o u r   t e x t   f i l e   -   a l t h o u g h ,   s i n c e   i t ' s   t h e   d e f a u l t   l e v e l ,   w h y   b o t h e r ?  ��  ��  � l 		�	�.����. m  	�	�// �00� L i k e w i s e ,   f o r   t h e   " t o p "   l a y e r ,   u s e   " 1 0 0 0 " . 
   
 T h e   b i g g e r   t h e   f i l e   t h e   l o n g e r   a n d   l o n g e r   t h e   s c r i p t   t a k e s ,   i n   a   k i n d   o f   e x p o n e n t i a l   w a y   ( s o   y o u   m a y   w a n t   t o   s p l i t   t h e   f i l e   u p   i n t o   c h u n k s ,   a n d   d o   a   b i t   a t   a   t i m e ) .  ��  ��  � l 		�	�1����1 m  	�	�22 �33 � T h e   s p e e d   a l s o   d e p e n d s   o n   t h e   n u m b e r   o f   c o l u m n s ;   w i t h   2 0 0   l i n e s   s e t t i n g   1 0 0   p r o p e r t i e s / l e v e l s   e x p e c t   i t   t o   t a k e   a t   l e a s t  ��  ��  � l 		�	�4����4 m  	�	�55 �66  1 5   m i n u t e s . . .��  ��  � ��78
�� 
appr7 o  	�	����� 0 dialogtitle dialogTitle8 ��9:
�� 
disp9 l 
	�	�;����; m  	�	����� ��  ��  : ��<=
�� 
btns< J  	�	�>> ?@? m  	�	�AA �BB  < < <   T o   p a g e   1@ CDC m  	�	�EE �FF 2 C o p y   h e a d e r s   t o   C l i p b o a r dD G��G m  	�	�HH �II  B a c k   t o   s t a r t��  = ��J��
�� 
dfltJ m  	�	�KK �LL  G e t   o n   w i t h   i t��  ��  ��  � o      ���� (0 instructionbutton2 instructionButton2� M��M Z  	�
$NOP��N = 	�
QRQ o  	�	����� (0 instructionbutton2 instructionButton2R m  	�
SS �TT 2 C o p y   h e a d e r s   t o   C l i p b o a r dO n 

UVU I  

��W����  0 totheclipboard toTheClipboardW X��X o  


���� 20 acceptablecolumnheaders acceptableColumnHeaders��  ��  V  f  

P YZY = 

[\[ o  

���� (0 instructionbutton2 instructionButton2\ m  

]] �^^  B a c k   t o   s t a r tZ _��_ r  

 `a` m  

��
�� boovtruea o      ���� "0 finishedreading finishedReading��  ��  ��  � > 	�	�bcb o  	�	����� (0 instructionbutton2 instructionButton2c m  	�	�dd �ee 2 C o p y   h e a d e r s   t o   C l i p b o a r d��  �  �  �  B = ��fgf o  ������ "0 finishedreading finishedReadingg m  ����
�� boovtrue�9  �>  �=  4 h��h l 
7
7��������  ��  ��  ��   = v}iji o  vy���� 0 thenavigator theNavigatorj m  y|kk �ll  G e t   o n   w i t h   i t
 mnm l 
>
>��������  ��  ��  n opo l 
>
>��qr��  q   Check QLab is running   r �ss ,   C h e c k   Q L a b   i s   r u n n i n gp tut l 
>
>��������  ��  ��  u vwv O  
>
axyx r  
D
`z{z I 
D
\��|��
�� .corecnte****       ****| l 
D
X}����} 6 
D
X~~ 2  
D
I��
�� 
prcs = 
L
W��� 1  
M
Q��
�� 
pnam� m  
R
V�� ���  Q L a b��  ��  ��  { o      ���� 0 qlabisrunning qLabIsRunningy m  
>
A���                                                                                  sevs  alis    �  Macintosh HD               Ѳ(�H+   8�=System Events.app                                               <2���        ����  	                CoreServices    Ѳ�      ���     8�= 8�< 8�;  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  w ��� Z  
b
�������� = 
b
g��� o  
b
e���� 0 qlabisrunning qLabIsRunning� m  
e
f����  � k  
j
��� ��� I 
j
�����
�� .sysodlogaskr        TEXT� m  
j
m�� ��� ( Q L a b   i s   n o t   r u n n i n g .� ����
�� 
appr� o  
p
q���� 0 dialogtitle dialogTitle� ����
�� 
disp� m  
t
u����  � ����
�� 
btns� J  
x
}�� ���� m  
x
{�� ���  O K��  � ����
�� 
dflt� m  
�
��� ���  O K� �����
�� 
givu� m  
�
����� ��  � ���� L  
�
�����  ��  ��  ��  � ��� l 
�
���������  ��  ��  � ��� l 
�
�������  �   Test for a workspace   � ��� *   T e s t   f o r   a   w o r k s p a c e� ��� l 
�
���������  ��  ��  � ��� O  
�
���� Q  
�
����� e  
�
��� n  
�
���� 1  
�
���
�� 
qSEL� 4 
�
����
�� 
qDoc� m  
�
����� � R      ������
�� .ascrerr ****      � ****��  ��  � k  
�
��� ��� I 
�
�����
�� .sysodlogaskr        TEXT� m  
�
��� ��� F T h e r e   i s   n o   w o r k s p a c e   o p e n   i n   Q L a b .� ����
�� 
appr� o  
�
����� 0 dialogtitle dialogTitle� ����
�� 
disp� l 

�
������� m  
�
�����  ��  ��  � ����
�� 
btns� J  
�
��� ���� m  
�
��� ���  O K��  � ����
�� 
dflt� m  
�
��� ���  O K� �����
�� 
givu� m  
�
����� ��  � ���� L  
�
�����  ��  � m  
�
����                                                                                      @ alis    `  Macintosh HD               Ѳ(�H+   
��QLab.app                                                        �����\        ����  	                	Downloads     Ѳ�      ���\     
�� 
�� �9  ,Macintosh HD:Users: cmg: Downloads: QLab.app    Q L a b . a p p    M a c i n t o s h   H D  Users/cmg/Downloads/QLab.app  /    
��  � ��� l 
�
���~�}�  �~  �}  � ��� l 
�
��|���|  �   Get the file   � ���    G e t   t h e   f i l e� ��� l 
�
��{�z�y�{  �z  �y  � ��� r  
�
���� I 
�
��x�w�
�x .sysostdfalis    ��� null�w  � �v��
�v 
prmp� m  
�
��� ��� P P l e a s e   s e l e c t   a   t a b - d e l i m i t e d   t e x t   f i l e :� �u��
�u 
dflc� l 
�
���t�s� I 
�
��r��q
�r .earsffdralis        afdr� m  
�
��p
�p afdrdesk�q  �t  �s  � �o��n
�o 
lfiv� m  
�
��m
�m boovfals�n  � o      �l�l 0 thefile theFile� ��� l 
�
��k�j�i�k  �j  �i  � ��� r  
���� m  
� �� ���  � n     ��� 1  �h
�h 
txdl� 1   �g
�g 
ascr� ��� l �f�e�d�f  �e  �d  � ��� Q  #���� r  ��� I �c��b
�c .rdwrread****        ****� o  �a�a 0 thefile theFile�b  � o      �`�` 0 thetext theText� R      �_�^�]
�_ .ascrerr ****      � ****�^  �]  � k  #�� ��� n  ��� I   �\�[�Z�\ 0 exitstrategy exitStrategy�[  �Z  �  f  � ��Y� L  !#�X�X  �Y  �    l $$�W�V�U�W  �V  �U    O  $~ l *} k  *}		 

 r  *5 n  *1 1  -1�T
�T 
extn o  *-�S�S 0 thefile theFile o      �R�R 0 theextension theExtension �Q Z  6}�P = 6= o  69�O�O 0 theextension theExtension m  9< �   r  @K n  @G 1  CG�N
�N 
pnam o  @C�M�M 0 thefile theFile o      �L�L 0 thename theName�P   k  N}  r  NY  n  NU!"! 1  QU�K
�K 
pnam" o  NQ�J�J 0 thefile theFile  o      �I�I 0 thefullname theFullName #�H# r  Z}$%$ n  Zy&'& 7]y�G()
�G 
ctxt( m  ce�F�F ) l fx*�E�D* \  fx+,+ \  gv-.- l gn/�C�B/ n  gn010 1  jn�A
�A 
leng1 o  gj�@�@ 0 thefullname theFullName�C  �B  . l nu2�?�>2 n  nu343 1  qu�=
�= 
leng4 o  nq�<�< 0 theextension theExtension�?  �>  , m  vw�;�; �E  �D  ' o  Z]�:�: 0 thefullname theFullName% o      �9�9 0 thename theName�H  �Q   ; 5 Get just the name of the file, without the extension    �55 j   G e t   j u s t   t h e   n a m e   o f   t h e   f i l e ,   w i t h o u t   t h e   e x t e n s i o n m  $'66�                                                                                  sevs  alis    �  Macintosh HD               Ѳ(�H+   8�=System Events.app                                               <2���        ����  	                CoreServices    Ѳ�      ���     8�= 8�< 8�;  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   787 l �8�7�6�8  �7  �6  8 9:9 l �5;<�5  ; "  Set up translation matrices   < �== 8   S e t   u p   t r a n s l a t i o n   m a t r i c e s: >?> l �4�3�2�4  �3  �2  ? @A@ r  �BCB 1  ��1
�1 
tab C n     DED 1  ���0
�0 
txdlE 1  ���/
�/ 
ascrA FGF l ���.�-�,�.  �-  �,  G HIH Q  ��JKLJ l ��MNOM r  ��PQP n  ��RSR 2  ���+
�+ 
citmS n  ��TUT 4  ���*V
�* 
cparV m  ���)�) U o  ���(�( 0 thetext theTextQ o      �'�' 0 	headerrow 	headerRowN   Pull headers from file   O �WW .   P u l l   h e a d e r s   f r o m   f i l eK R      �&�%�$
�& .ascrerr ****      � ****�%  �$  L k  ��XX YZY n ��[\[ I  ���#�"�!�# 0 exitstrategy exitStrategy�"  �!  \  f  ��Z ]� ] L  ����  �   I ^_^ l ������  �  �  _ `a` Z  ��bc��b H  ��dd E ��efe o  ���� 0 	headerrow 	headerRowf m  ��gg �hh  t y p ec l ��ijki k  ��ll mnm I ���op
� .sysodlogaskr        TEXTo b  ��qrq m  ��ss �tt z T h e   h e a d e r   r o w   o f   t h i s   f i l e   d o e s n ' t   c o n t a i n   t h e   w o r d   " t y p e " ,  r l 	��u��u m  ��vv �ww � s o   I   d o n ' t   k n o w   w h i c h   c o l u m n   t o   l o o k   i n   t o   s p e c i f y   w h a t   c u e s   t o   m a k e . . .�  �  p �xy
� 
apprx o  ���� 0 dialogtitle dialogTitley �z{
� 
dispz l 
��|��| m  ����  �  �  { �}~
� 
btns} J  �� ��� m  ���� ���  O K�  ~ ���
� 
dflt� m  ���� ���  O K�  n ��� r  ����� o  ���� 0 currenttids currentTIDs� n     ��� 1  ���

�
 
txdl� 1  ���	
�	 
ascr� ��� L  ����  �  j : 4 Won't know what cues to make without a type column!   k ��� h   W o n ' t   k n o w   w h a t   c u e s   t o   m a k e   w i t h o u t   a   t y p e   c o l u m n !�  �  a ��� l ������  �  �  � ��� Y  �:������ l �5���� k  �5�� ��� s  ����� m  ����  � n      ���  ;  ��� o  ��� �  *0 propertiestocolumns propertiesToColumns� ���� Y  �5�������� Z  0������� = ��� n  ��� 4  ���
�� 
cobj� o  ���� 0 j  � o  ���� 0 	headerrow 	headerRow� n  ��� 4  ���
�� 
cobj� o  ���� 0 i  � o  ���� 20 acceptablecolumnheaders acceptableColumnHeaders� r  ",��� o  "#���� 0 j  � n      ��� 4  &+���
�� 
cobj� o  )*���� 0 i  � o  #&���� *0 propertiestocolumns propertiesToColumns��  ��  �� 0 j  � m  ���� � I 	�����
�� .corecnte****       ****� o  ���� 0 	headerrow 	headerRow��  ��  ��  � K E Find which properties are in text file, and which column they are in   � ��� �   F i n d   w h i c h   p r o p e r t i e s   a r e   i n   t e x t   f i l e ,   a n d   w h i c h   c o l u m n   t h e y   a r e   i n� 0 i  � m  ������ � I �������
�� .corecnte****       ****� o  ������ 20 acceptablecolumnheaders acceptableColumnHeaders��  �  � ��� l ;;��������  ��  ��  � ��� r  ;E��� N  ;A�� o      ���� *0 propertiestocolumns propertiesToColumns� o      ���� 00 propertiestocolumnsref propertiesToColumnsRef� ��� l FF��������  ��  ��  � ��� Y  Ft�������� l Vo���� Z  Vo������� E  Vb��� n  V^��� 4  Y^���
�� 
cobj� o  \]���� 0 i  � o  VY���� 0 	headerrow 	headerRow� m  ^a�� ���  ,� s  ek��� o  ef���� 0 i  � n      ���  ;  ij� o  fi���� 0 levelcolumns levelColumns��  ��  � 3 - Make a list of all columns flagged as levels   � ��� Z   M a k e   a   l i s t   o f   a l l   c o l u m n s   f l a g g e d   a s   l e v e l s�� 0 i  � m  IJ���� � I JQ�����
�� .corecnte****       ****� o  JM���� 0 	headerrow 	headerRow��  ��  � ��� l uu��������  ��  ��  � ��� r  u���� n  u}��� 4  x}���
�� 
cobj� m  {|���� � o  ux���� 00 propertiestocolumnsref propertiesToColumnsRef� o      ���� 0 
typecolumn 
typeColumn� ��� l ����������  ��  ��  � ��� l ��������  �   Add a root path?   � ��� "   A d d   a   r o o t   p a t h ?� ��� l ����������  ��  ��  � ��� r  ����� n  ����� 1  ����
�� 
bhit� l �������� I ������
�� .sysodlogaskr        TEXT� m  ���� ��� � W o u l d   y o u   l i k e   m e   t o   p r e f i x   t h e   f i l e   t a r g e t s   i n   y o u r   t e x t   f i l e   w i t h   a   c o m m o n   r o o t   p a t h ?� ����
�� 
appr� l 	�������� o  ������ 0 dialogtitle dialogTitle��  ��  � ����
�� 
disp� m  ������ � ����
�� 
btns� J  ���� ��� m  ���� ���  Y e s� ���� m  ���� �    N o��  � ����
�� 
dflt m  �� �  N o��  ��  ��  � o      ���� 0 setrootpath setRootPath�  l ����������  ��  ��    Z  ��	��
 = �� o  ������ 0 setrootpath setRootPath m  �� �  Y e s	 k  ��  r  �� l ������ I ������
�� .sysostflalis    ��� null��   ��
�� 
prmp l 	������ m  �� � � P l e a s e   s e l e c t   t h e   f o l d e r   t h a t   c o n t a i n s   y o u r   a u d i o   &   v i d e o   f i l e s :��  ��   ��
�� 
dflc l ������ I ������
�� .earsffdralis        afdr m  ����
�� afdrcusr��  ��  ��   ����
�� 
lfiv m  ����
�� boovfals��  ��  ��   o      ���� 0 
pathfinder 
pathFinder  ��  r  ��!"! n  ��#$# 1  ����
�� 
psxp$ o  ������ 0 
pathfinder 
pathFinder" o      ���� 0 
pathprefix 
pathPrefix��  ��  
 r  ��%&% m  ��'' �((  & o      ���� 0 
pathprefix 
pathPrefix )*) l ����������  ��  ��  * +,+ l ����-.��  -   Annotate every line?   . �// *   A n n o t a t e   e v e r y   l i n e ?, 010 l ����������  ��  ��  1 232 l ��4564 I ����7��
�� .sysodelanull��� ��� nmbr7 m  ��88 ?�      ��  5 9 3 Otherwise you don't notice the dialog has changed!   6 �99 f   O t h e r w i s e   y o u   d o n ' t   n o t i c e   t h e   d i a l o g   h a s   c h a n g e d !3 :;: l ����������  ��  ��  ; <=< r  �>?> n  �@A@ 1  ��
�� 
bhitA l 	�B����B l �C����C I ���DE
�� .sysodlogaskr        TEXTD m  ��FF �GG � W o u l d   y o u   l i k e   m e   t o   c o p y   e a c h   l i n e   f r o m   t h e   t e x t   f i l e   i n t o   t h e   n o t e s   o f   t h e   c u e   t h a t   i s   m a d e   f r o m   i t ?E ��HI
�� 
apprH l 	��J����J o  ������ 0 dialogtitle dialogTitle��  ��  I ��KL
�� 
dispK m  � ���� L ��MN
�� 
btnsM J  OO PQP m  RR �SS  Y e sQ T��T m  	UU �VV  N o��  N ��W��
�� 
dfltW m  XX �YY  N o��  ��  ��  ��  ��  ? o      �� &0 annotateeveryline annotateEveryLine= Z[Z l   �~�}�|�~  �}  �|  [ \]\ l   �{^_�{  ^ &   How long is this going to take?   _ �`` @   H o w   l o n g   i s   t h i s   g o i n g   t o   t a k e ?] aba l   �z�y�x�z  �y  �x  b cdc r   /efe I  +�wg�v
�w .corecnte****       ****g n   'hih 2 #'�u
�u 
cpari o   #�t�t 0 thetext theText�v  f o      �s�s 0 	counttext 	countTextd jkj l 0Clmnl r  0Copo ]  0?qrq o  03�r�r 0 	counttext 	countTextr l 3>s�q�ps ^  3>tut l 3:v�o�nv I 3:�mw�l
�m .corecnte****       ****w o  36�k�k 0 	headerrow 	headerRow�l  �o  �n  u m  :=�j�j d�q  �p  p o      �i�i 0 fudgefactor fudgeFactorm J D Account for variable number of steps that will be run for each cue;   n �xx �   A c c o u n t   f o r   v a r i a b l e   n u m b e r   o f   s t e p s   t h a t   w i l l   b e   r u n   f o r   e a c h   c u e ;k yzy l  DD�h{|�h  { ) # testing was done with 100 headers    | �}} F   t e s t i n g   w a s   d o n e   w i t h   1 0 0   h e a d e r s  z ~~ l DD�g���g  � } w ###FIXME### Current estimate based on second order polynomial interpolation of 3 sample data points (!): get more data   � ��� �   # # # F I X M E # # #   C u r r e n t   e s t i m a t e   b a s e d   o n   s e c o n d   o r d e r   p o l y n o m i a l   i n t e r p o l a t i o n   o f   3   s a m p l e   d a t a   p o i n t s   ( ! ) :   g e t   m o r e   d a t a ��� r  D]��� [  DY��� [  DO��� m  DG�f�f F� ]  GN��� m  GJ�� ?�      � o  JM�e�e 0 fudgefactor fudgeFactor� ]  OX��� m  OR�� ?�t�j~��� l RW��d�c� a  RW��� o  RU�b�b 0 fudgefactor fudgeFactor� m  UV�a�a �d  �c  � o      �`�` 0 theeta theETA� ��� Z  ^
���_�^� ? ^e��� o  ^a�]�] 0 theeta theETA� m  ad�\�\ (� l h���� k  h�� ��� r  ht��� n hp��� I  ip�[��Z�[ 0 	makenicet 	makeNiceT� ��Y� o  il�X�X 0 theeta theETA�Y  �Z  �  f  hi� o      �W�W 0 
timestring 
timeString� ��� r  u|��� m  ux�� ���    s e c o n d s� o      �V�V "0 spuriousplurals spuriousPlurals� ��U� Y  }��T���� k  ��� ��� Z  �����S�R� = ����� o  ���Q�Q 0 i  � m  ���P�P � r  ����� m  ���� ���    s e c o n d� o      �O�O "0 spuriousplurals spuriousPlurals�S  �R  � ��� r  ����� n  ����� 1  ���N
�N 
bhit� l ����M�L� I ���K��
�K .sysodlogaskr        TEXT� b  ����� b  ����� l ����J�I� c  ����� b  ����� b  ����� b  ����� b  ����� l ����H�G� c  ����� b  ����� m  ���� ���  T h e r e   a r e  � o  ���F�F 0 	counttext 	countText� m  ���E
�E 
TEXT�H  �G  � m  ���� ��� �   l i n e s   i n   t h i s   t e x t   f i l e . 
   
 B a s e d   o n   c u r r e n t   t e s t s ,   t h i s   m a y   t a k e   a b o u t  � o  ���D�D 0 
timestring 
timeString� m  ���� ��� T   t o   p r o c e s s ,   p o s s i b l y   l o n g e r .   
   
 Y o u   h a v e  � o  ���C�C 0 i  � m  ���B
�B 
TEXT�J  �I  � o  ���A�A "0 spuriousplurals spuriousPlurals� m  ���� ��� &   t o   h i t   " C a n c e l " . . .� �@��
�@ 
appr� o  ���?�? 0 dialogtitle dialogTitle� �>��
�> 
disp� l 
����=�<� m  ���;�;  �=  �<  � �:��
�: 
btns� J  ���� ��� m  ���� ���  C a n c e l� ��9� m  ���� ���  O K�9  � �8��
�8 
dflt� m  ���� ���  O K� �7��
�7 
cbtn� m  ���� ���  C a n c e l� �6��5
�6 
givu� m  ���4�4 �5  �M  �L  � o      �3�3 0 goonthen goOnThen� ��2� Z  ����1�0� = ����� o  ���/�/ 0 goonthen goOnThen� m  ���� ���  O K�  S  ���1  �0  �2  �T 0 i  � m  ���.�. 
� m  ���-�- � m  ���,�,���U  � : 4 Don't waste 10s telling you it's going to take 30s!   � �   h   D o n ' t   w a s t e   1 0 s   t e l l i n g   y o u   i t ' s   g o i n g   t o   t a k e   3 0 s !�_  �^  �  l �+�*�)�+  �*  �)    l �(�(     Now, to business    � "   N o w ,   t o   b u s i n e s s 	 l �'�&�%�'  �&  �%  	 

 O  3D k  3C  l �$�#�"�$  �#  �"    I �!� �
�! .miscactvnull��� ��� null�   �    l ����  �  �    I :�
� .sysodlogaskr        TEXT m   � ( O n e   m o m e n t   c a l l e r . . . �
� 
appr o  �� 0 dialogtitle dialogTitle �
� 
disp m  !"��  � 
� 
btns J  %*!! "�" m  %(## �$$  O K�    �%&
� 
dflt% m  -0'' �((  O K& �)�
� 
givu) m  34�� �   *+* l ;;����  �  �  + ,-, r  ;H./. n  ;D010 1  @D�
� 
aSlt1 l ;@2��2 I ;@�
�	�
�
 .misccurdldt    ��� null�	  �  �  �  / o      �� 0 	starttime 	startTime- 343 l II����  �  �  4 565 O  I2�787 k  R2�99 :;: l RR����  �  �  ; <=< l RR� >?�   > ) # Record the header row, if required   ? �@@ F   R e c o r d   t h e   h e a d e r   r o w ,   i f   r e q u i r e d= ABA l RR��������  ��  ��  B CDC Z  R�EF����E = RYGHG o  RU���� &0 annotateeveryline annotateEveryLineH m  UXII �JJ  Y e sF k  \�KK LML r  \hNON n \dPQP I  ]d��R���� &0 makeniceparagraph makeNiceParagraphR S��S o  ]`���� 0 	headerrow 	headerRow��  ��  Q  f  \]O o      ���� 0 niceparagraph niceParagraphM TUT I it����V
�� .QLabmakenull���     qDoc��  V ��W��
�� 
newTW m  mpXX �YY  M e m o��  U Z[Z r  u�\]\ n  u�^_^ 4 ~���`
�� 
cobj` m  ��������_ l u~a����a c  u~bcb 1  uz��
�� 
qSELc m  z}��
�� 
list��  ��  ] o      ���� 0 newcue newCue[ ded r  ��fgf m  ��hh �ii > < < < <   H e a d e r   f r o m   t e x t   f i l e   > > > >g n      jkj 1  ����
�� 
qNamk o  ������ 0 newcue newCuee l��l r  ��mnm b  ��opo b  ��qrq b  ��sts b  ��uvu m  ��ww �xx * L i n e   1   o f   t e x t   f i l e   "v o  ������ 0 thename theNamet m  ��yy �zz 
 " :   |  r o  ������ 0 niceparagraph niceParagraphp m  ��{{ �||    |n n      }~} 1  ����
�� 
qNot~ o  ������ 0 newcue newCue��  ��  ��  D � l ����������  ��  ��  � ��� Y  �2��������� l �2����� k  �2��� ��� l ����������  ��  ��  � ��� r  ����� n  ����� 2  ����
�� 
citm� n  ����� 4  �����
�� 
cpar� o  ������ 0 i  � o  ������ 0 thetext theText� o      ���� 0 	therecord 	theRecord� ��� l ����������  ��  ��  � ��� r  ����� n ����� I  ��������� &0 makeniceparagraph makeNiceParagraph� ���� o  ������ 0 	therecord 	theRecord��  ��  �  f  ��� o      ���� 0 niceparagraph niceParagraph� ��� l ����������  ��  ��  � ��� V  ���� l ������ s  ����� c  ����� m  ���� ���  � m  ����
�� 
TEXT� n      ���  ;  ��� o  ������ 0 	therecord 	theRecord� ? 9 Pad out any missing cells from end of line, just in case   � ��� r   P a d   o u t   a n y   m i s s i n g   c e l l s   f r o m   e n d   o f   l i n e ,   j u s t   i n   c a s e� A ����� l �������� I �������
�� .corecnte****       ****� o  ������ 0 	therecord 	theRecord��  ��  ��  � l �������� I �������
�� .corecnte****       ****� o  ������ 0 	headerrow 	headerRow��  ��  ��  � ��� l ��������  ��  ��  � ��� r  ��� l 
������ N  
�� o      ���� 0 	therecord 	theRecord��  ��  � o      ���� 0 therecordref theRecordRef� ��� l ��������  ��  ��  � ��� Q  /���� r   ��� n  ��� 4  ���
�� 
cobj� o  ���� 0 
typecolumn 
typeColumn� o  ���� 0 therecordref theRecordRef� o      ���� 0 thetype theType� R      ������
�� .ascrerr ****      � ****��  ��  � l (/���� r  (/��� m  (+�� ���  U n a c c e p t a b l e� o      ���� 0 thetype theType� !  Flag it for the next stage   � ��� 6   F l a g   i t   f o r   t h e   n e x t   s t a g e� ��� l 00��������  ��  ��  � ��� Z  01������� H  08�� E 07��� o  03���� "0 acceptabletypes acceptableTypes� o  36���� 0 thetype theType� k  ;��� ��� I ;F�����
�� .QLabmakenull���     qDoc��  � �����
�� 
newT� m  ?B�� ���  M e m o��  � ��� r  GY��� n  GU��� 4 PU���
�� 
cobj� m  ST������� l GP������ c  GP��� 1  GL��
�� 
qSEL� m  LO��
�� 
list��  ��  � o      ���� 0 newcue newCue� ��� r  Ze��� m  Z]�� ��� 4 ! ! ! !   U n p r o c e s s e d   l i n e   ! ! ! !� n      ��� 1  `d��
�� 
qNam� o  ]`���� 0 newcue newCue� ���� r  f���� b  f��� b  f{��� b  fw��� b  fs� � b  fo b  fk m  fi � " U n p r o c e s s e d   l i n e   o  ij���� 0 i   m  kn �    o f   t e x t   f i l e   "  o  or���� 0 thename theName� m  sv		 �

 
 " :   |  � o  wz���� 0 niceparagraph niceParagraph� m  {~ �    |� n       1  ����
�� 
qNot o  ����� 0 newcue newCue��  ��  � k  �1�  I ������
�� .QLabmakenull���     qDoc��   ����
�� 
newT o  ������ 0 thetype theType��    r  �� n  �� 4 ����
�� 
cobj m  �������� l ������ c  �� 1  ����
�� 
qSEL m  ����
�� 
list��  ��   o      ���� 0 newcue newCue  l ����������  ��  ��    !  Z  ��"#����" = ��$%$ o  ������ &0 annotateeveryline annotateEveryLine% m  ��&& �''  Y e s# r  ��()( b  ��*+* b  ��,-, b  ��./. b  ��010 b  ��232 b  ��454 m  ��66 �77  M a d e   f r o m   l i n e  5 o  ������ 0 i  3 m  ��88 �99    o f   t e x t   f i l e   "1 o  ������ 0 thename theName/ m  ��:: �;; 
 " :   |  - o  ���� 0 niceparagraph niceParagraph+ m  ��<< �==    |) n      >?> 1  ���~
�~ 
qNot? o  ���}�} 0 newcue newCue��  ��  ! @A@ l ���|�{�z�|  �{  �z  A BCB l ��DEFD r  ��GHG m  ���y
�y boovfalsH o      �x�x 0 ohdear ohDearE z t A simple flag to detect problems (not worth the effort of trying to attach a code to show which property(s) failed)   F �II �   A   s i m p l e   f l a g   t o   d e t e c t   p r o b l e m s   ( n o t   w o r t h   t h e   e f f o r t   o f   t r y i n g   t o   a t t a c h   a   c o d e   t o   s h o w   w h i c h   p r o p e r t y ( s )   f a i l e d )C JKJ l ���w�v�u�w  �v  �u  K LML l ���tNO�t  N g a These if�then clauses set the relevant property on newCue based on the contents of the text file   O �PP �   T h e s e   i f & t h e n   c l a u s e s   s e t   t h e   r e l e v a n t   p r o p e r t y   o n   n e w C u e   b a s e d   o n   t h e   c o n t e n t s   o f   t h e   t e x t   f i l eM QRQ l ���s�r�q�s  �r  �q  R STS Z  �.UV�p�oU > ��WXW n  ��YZY 4  ���n[
�n 
cobj[ m  ���m�m Z o  ���l�l 00 propertiestocolumnsref propertiesToColumnsRefX m  ���k�k  V l �*\]^\ Q  �*_`a_ l �bcdb k  �ee fgf r  �hih n  ��jkj 4  ���jl
�j 
cobjl l ��m�i�hm n  ��non 4  ���gp
�g 
cobjp m  ���f�f o o  ���e�e 00 propertiestocolumnsref propertiesToColumnsRef�i  �h  k o  ���d�d 0 therecordref theRecordRefi o      �c�c 0 theitem theItemg q�bq Z  rs�a�`r > tut o  �_�_ 0 theitem theItemu m  
vv �ww  s l xyzx r  {|{ o  �^�^ 0 theitem theItem| n      }~} 1  �]
�] 
pnam~ o  �\�\ 0 newcue newCuey Q K Had to put all these in to stop empty lines being interpreted as "0" (etc)   z � �   H a d   t o   p u t   a l l   t h e s e   i n   t o   s t o p   e m p t y   l i n e s   b e i n g   i n t e r p r e t e d   a s   " 0 "   ( e t c )�a  �`  �b  c � z Putting try round every step stops the whole thing grinding to a halt if a field has a rogue entry that QLab doesn't like   d ��� �   P u t t i n g   t r y   r o u n d   e v e r y   s t e p   s t o p s   t h e   w h o l e   t h i n g   g r i n d i n g   t o   a   h a l t   i f   a   f i e l d   h a s   a   r o g u e   e n t r y   t h a t   Q L a b   d o e s n ' t   l i k e` R      �[�Z�Y
�[ .ascrerr ****      � ****�Z  �Y  a r  %*��� m  %&�X
�X boovtrue� o      �W�W 0 ohdear ohDear]   index2_q_number   ^ ���     i n d e x 2 _ q _ n u m b e r�p  �o  T ��� l //�V�U�T�V  �U  �T  � ��� Z  /~���S�R� > /9��� n  /7��� 4  27�Q�
�Q 
cobj� m  56�P�P � o  /2�O�O 00 propertiestocolumnsref propertiesToColumnsRef� m  78�N�N  � l <z���� Q  <z���� k  ?m�� ��� r  ?S��� n  ?O��� 4  BO�M�
�M 
cobj� l EN��L�K� n  EN��� 4  HM�J�
�J 
cobj� m  KL�I�I � o  EH�H�H 00 propertiestocolumnsref propertiesToColumnsRef�L  �K  � o  ?B�G�G 0 therecordref theRecordRef� o      �F�F 0 theitem theItem� ��E� Z  Tm���D�C� > T[��� o  TW�B�B 0 theitem theItem� m  WZ�� ���  � r  ^i��� o  ^a�A�A 0 theitem theItem� n      ��� 1  dh�@
�@ 
qNam� o  ad�?�? 0 newcue newCue�D  �C  �E  � R      �>�=�<
�> .ascrerr ****      � ****�=  �<  � r  uz��� m  uv�;
�; boovtrue� o      �:�: 0 ohdear ohDear�   index3_q_name   � ���    i n d e x 3 _ q _ n a m e�S  �R  � ��� l �9�8�7�9  �8  �7  � ��� Z  ���6�5� > ���� n  ���� 4  ���4�
�4 
cobj� m  ���3�3 � o  ��2�2 00 propertiestocolumnsref propertiesToColumnsRef� m  ���1�1  � l ����� Q  ����� k  ���� ��� r  ����� n  ����� 4  ���0�
�0 
cobj� l ����/�.� n  ����� 4  ���-�
�- 
cobj� m  ���,�, � o  ���+�+ 00 propertiestocolumnsref propertiesToColumnsRef�/  �.  � o  ���*�* 0 therecordref theRecordRef� o      �)�) 0 theitem theItem� ��(� Z  �����'�&� > ����� o  ���%�% 0 theitem theItem� m  ���� ���  � l ������ k  ���� ��� r  ����� c  ����� n  ����� 1  ���$
�$ 
qNot� o  ���#�# 0 newcue newCue� m  ���"
�" 
TEXT� o      �!�! 0 existingnotes existingNotes� �� � Z  ������� > ����� o  ���� 0 existingnotes existingNotes� m  ���� ���  m i s s i n g   v a l u e� r  ����� b  ����� b  ����� b  ����� o  ���� 0 theitem theItem� o  ���
� 
ret � o  ���
� 
ret � o  ���� 0 existingnotes existingNotes� n      ��� 1  ���
� 
qNot� o  ���� 0 newcue newCue�  � r  ����� o  ���� 0 theitem theItem� n      ��� 1  ���
� 
qNot� o  ���� 0 newcue newCue�   � X R Prevents returns being added before line from text file if no notes given for cue   � ��� �   P r e v e n t s   r e t u r n s   b e i n g   a d d e d   b e f o r e   l i n e   f r o m   t e x t   f i l e   i f   n o   n o t e s   g i v e n   f o r   c u e�'  �&  �(  � R      ���
� .ascrerr ****      � ****�  �  � r  ���� m  ���
� boovtrue� o      �� 0 ohdear ohDear�   index4_notes   � ���    i n d e x 4 _ n o t e s�6  �5  � ��� l ����  �  �  � ��� Z  ������ F  !� � E  o  
�
�
 0 index5_cue_target   o  
�	�	 0 thetype theType  >  n   4  �
� 
cobj m  ��  o  �� 00 propertiestocolumnsref propertiesToColumnsRef m  ��  � Q  $�	
 k  'u  r  'A c  '= n  '9 4  *9�
� 
cobj l -8�� n  -8 4  07�
� 
cobj m  36� �   o  -0���� 00 propertiestocolumnsref propertiesToColumnsRef�  �   o  '*���� 0 therecordref theRecordRef m  9<��
�� 
TEXT o      ���� 0 theitem theItem �� Z  Bu���� > BI o  BE���� 0 theitem theItem m  EH �   k  Lq   !"! r  Le#$# l La%����% 6 La&'& 4 LR��(
�� 
aCue( m  PQ���� ' = U`)*) 1  VZ��
�� 
pnam* o  [_���� 0 theitem theItem��  ��  $ o      ���� 0 	targetcue 	targetCue" +��+ r  fq,-, o  fi���� 0 	targetcue 	targetCue- n      ./. 1  lp��
�� 
qQTr/ o  il���� 0 newcue newCue��  ��  ��  ��  	 R      ������
�� .ascrerr ****      � ****��  ��  
 r  }�010 m  }~��
�� boovtrue1 o      ���� 0 ohdear ohDear�  �  � 232 l ����������  ��  ��  3 454 Z  �67����6 F  ��898 E ��:;: o  ������ 0 index6_file_target  ; o  ������ 0 thetype theType9 > ��<=< n  ��>?> 4  ����@
�� 
cobj@ m  ������ ? o  ������ 00 propertiestocolumnsref propertiesToColumnsRef= m  ������  7 Q  ��ABCA k  ��DD EFE r  ��GHG n  ��IJI 4  ����K
�� 
cobjK l ��L����L n  ��MNM 4  ����O
�� 
cobjO m  ������ N o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  J o  ������ 0 therecordref theRecordRefH o      ���� 0 theitem theItemF P��P Z  ��QR����Q > ��STS o  ������ 0 theitem theItemT m  ��UU �VV  R k  ��WW XYX O  ��Z[Z l ��\]^\ 4  ����_
�� 
file_ l ��`����` b  ��aba o  ������ 0 
pathprefix 
pathPrefixb o  ������ 0 theitem theItem��  ��  ]   Check file exists   ^ �cc $   C h e c k   f i l e   e x i s t s[ m  ��dd�                                                                                  sevs  alis    �  Macintosh HD               Ѳ(�H+   8�=System Events.app                                               <2���        ����  	                CoreServices    Ѳ�      ���     8�= 8�< 8�;  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  Y e��e r  ��fgf l ��h����h b  ��iji o  ������ 0 
pathprefix 
pathPrefixj o  ������ 0 theitem theItem��  ��  g n      klk 1  ����
�� 
qFTrl o  ������ 0 newcue newCue��  ��  ��  ��  B R      ������
�� .ascrerr ****      � ****��  ��  C r  ��mnm m  ����
�� boovtruen o      ���� 0 ohdear ohDear��  ��  5 opo l ��������  ��  ��  p qrq Z  [st����s > uvu n  wxw 4  ��y
�� 
cobjy m  ���� x o  ���� 00 propertiestocolumnsref propertiesToColumnsRefv m  ����  t l Wz{|z Q  W}~} k  J�� ��� r  *��� n  &��� 4  &���
�� 
cobj� l %������ n  %��� 4  $���
�� 
cobj� m   #���� � o  ���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  +J������� > +2��� o  +.���� 0 theitem theItem� m  .1�� ���  � k  5F�� ��� l 5D���� r  5D��� c  5<��� o  58���� 0 theitem theItem� m  8;��
�� 
doub� n      ��� 1  ?C��
�� 
qPre� o  <?���� 0 newcue newCue� , & Try to protect against invalid entry    � ��� L   T r y   t o   p r o t e c t   a g a i n s t   i n v a l i d   e n t r y  � ���� l  EE������  � � � (anything that expects text should be fine with a string from theText;
                                hopefully this qualifier means only numbers are passed when numbers are expected)    � ���t   ( a n y t h i n g   t h a t   e x p e c t s   t e x t   s h o u l d   b e   f i n e   w i t h   a   s t r i n g   f r o m   t h e T e x t ; 
                                                                 h o p e f u l l y   t h i s   q u a l i f i e r   m e a n s   o n l y   n u m b e r s   a r e   p a s s e d   w h e n   n u m b e r s   a r e   e x p e c t e d )  ��  ��  ��  ��  ~ R      ������
�� .ascrerr ****      � ****��  ��   r  RW��� m  RS��
�� boovtrue� o      ���� 0 ohdear ohDear{   index7_pre_wait   | ���     i n d e x 7 _ p r e _ w a i t��  ��  r ��� l \\��������  ��  ��  � ��� Z  \�������� F  \v��� E \c��� o  \_���� 0 index8_duration  � o  _b���� 0 thetype theType� > fr��� n  fp��� 4  ip���
�� 
cobj� m  lo���� � o  fi���� 00 propertiestocolumnsref propertiesToColumnsRef� m  pq����  � Q  y����� k  |��� ��� r  |���� n  |���� 4  ����
�� 
cobj� l �������� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  |���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  ��������� > ����� o  ������ 0 theitem theItem� m  ���� ���  � r  ����� c  ����� o  ������ 0 theitem theItem� m  ����
�� 
doub� n      ��� 1  ����
�� 
qDur� o  ������ 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  ����� m  ����
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  � ��� l ����~�}�  �~  �}  � ��� Z  ����|�{� > ����� n  ����� 4  ���z�
�z 
cobj� m  ���y�y 	� o  ���x�x 00 propertiestocolumnsref propertiesToColumnsRef� m  ���w�w  � l ����� Q  ����� k  ��� ��� r  ����� n  ����� 4  ���v�
�v 
cobj� l ����u�t� n  ����� 4  ���s�
�s 
cobj� m  ���r�r 	� o  ���q�q 00 propertiestocolumnsref propertiesToColumnsRef�u  �t  � o  ���p�p 0 therecordref theRecordRef� o      �o�o 0 theitem theItem� ��n� Z  ����m�l� > ����� o  ���k�k 0 theitem theItem� m  ���� ���  � r  ���� c  ����� o  ���j�j 0 theitem theItem� m  ���i
�i 
doub� n      ��� 1  ��h
�h 
qPos� o  ���g�g 0 newcue newCue�m  �l  �n  � R      �f�e�d
�f .ascrerr ****      � ****�e  �d  � r  ��� m  �c
�c boovtrue� o      �b�b 0 ohdear ohDear�   index9_post_wait   � �   "   i n d e x 9 _ p o s t _ w a i t�|  �{  �  l �a�`�_�a  �`  �_    Z  ��^�] > & n  $	
	 4  $�\
�\ 
cobj m   #�[�[ 

 o  �Z�Z 00 propertiestocolumnsref propertiesToColumnsRef m  $%�Y�Y   l )� Q  )� k  ,�  r  ,B n  ,> 4  />�X
�X 
cobj l 2=�W�V n  2= 4  5<�U
�U 
cobj m  8;�T�T 
 o  25�S�S 00 propertiestocolumnsref propertiesToColumnsRef�W  �V   o  ,/�R�R 0 therecordref theRecordRef o      �Q�Q 0 theitem theItem �P Z  C� !�O = CO"#" o  CF�N�N 0 theitem theItem# n  FN$%$ 4  IN�M&
�M 
cobj& m  LM�L�L % o  FI�K�K 0 constants10_continue_mode    r  R]'(' m  RU�J
�J ContNoCo( n      )*) 1  X\�I
�I 
qCon* o  UX�H�H 0 newcue newCue! +,+ = `l-.- o  `c�G�G 0 theitem theItem. n  ck/0/ 4  fk�F1
�F 
cobj1 m  ij�E�E 0 o  cf�D�D 0 constants10_continue_mode  , 232 r  oz454 m  or�C
�C ContDoCo5 n      676 1  uy�B
�B 
qCon7 o  ru�A�A 0 newcue newCue3 898 = }�:;: o  }��@�@ 0 theitem theItem; n  ��<=< 4  ���?>
�? 
cobj> m  ���>�> = o  ���=�= 0 constants10_continue_mode  9 ?�<? r  ��@A@ m  ���;
�; ContDoFoA n      BCB 1  ���:
�: 
qConC o  ���9�9 0 newcue newCue�<  �O  �P   R      �8�7�6
�8 .ascrerr ****      � ****�7  �6   r  ��DED m  ���5
�5 boovtrueE o      �4�4 0 ohdear ohDear   index10_continue_mode    �FF ,   i n d e x 1 0 _ c o n t i n u e _ m o d e�^  �]   GHG l ���3�2�1�3  �2  �1  H IJI Z  �KL�0�/K > ��MNM n  ��OPO 4  ���.Q
�. 
cobjQ m  ���-�- P o  ���,�, 00 propertiestocolumnsref propertiesToColumnsRefN m  ���+�+  L l �RSTR Q  �UVWU k  �XX YZY l ��[\][ r  ��^_^ n  ��`a` 4  ���*b
�* 
cobjb l ��c�)�(c n  ��ded 4  ���'f
�' 
cobjf m  ���&�& e o  ���%�% 00 propertiestocolumnsref propertiesToColumnsRef�)  �(  a o  ���$�$ 0 therecordref theRecordRef_ o      �#�# 0 theitem theItem\ ; 5 This prevents empty entries being treated as "false"   ] �gg j   T h i s   p r e v e n t s   e m p t y   e n t r i e s   b e i n g   t r e a t e d   a s   " f a l s e "Z h�"h Z  �ijk�!i = ��lml o  ��� �  0 theitem theItemm n  ��non 4  ���p
� 
cobjp m  ���� o o  ���� 0 constants11_armed  j r  ��qrq m  ���
� boovtruer n      sts 1  ���
� 
qArmt o  ���� 0 newcue newCuek uvu = ��wxw o  ���� 0 theitem theItemx n  ��yzy 4  ���{
� 
cobj{ m  ���� z o  ���� 0 constants11_armed  v |�| r   	}~} m   �
� boovfals~ n      � 1  �
� 
qArm� o  �� 0 newcue newCue�  �!  �"  V R      ���
� .ascrerr ****      � ****�  �  W r  ��� m  �
� boovtrue� o      �� 0 ohdear ohDearS   index11_armed   T ���    i n d e x 1 1 _ a r m e d�0  �/  J ��� l ���
�  �  �
  � ��� Z  ����	�� > +��� n  )��� 4  ")��
� 
cobj� m  %(�� � o  "�� 00 propertiestocolumnsref propertiesToColumnsRef� m  )*��  � l .����� Q  .����� k  1��� ��� r  1G��� n  1C��� 4  4C��
� 
cobj� l 7B���� n  7B��� 4  :A� �
�  
cobj� m  =@���� � o  7:���� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  14���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  H������� = HT��� o  HK���� 0 theitem theItem� n  KS��� 4  NS���
�� 
cobj� m  QR���� � o  KN���� 0 constants12_midi_trigger  � r  Wb��� m  WZ��
�� YorNYyes� n      ��� 1  ]a��
�� 
qUMT� o  Z]���� 0 newcue newCue� ��� = eq��� o  eh���� 0 theitem theItem� n  hp��� 4  kp���
�� 
cobj� m  no���� � o  hk���� 0 constants12_midi_trigger  � ���� r  t��� m  tw��
�� YorNNnoo� n      ��� 1  z~��
�� 
qUMT� o  wz���� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  ����� m  ����
�� boovtrue� o      ���� 0 ohdear ohDear�   index12_midi_trigger   � ��� *   i n d e x 1 2 _ m i d i _ t r i g g e r�	  �  � ��� l ����������  ��  ��  � ��� Z  ��������� > ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef� m  ������  � l ������ Q  ������ k  �s�� ��� r  ����� n  ����� 4  �����
�� 
cobj� l �������� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ������ 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  �s������ = ����� o  ������ 0 theitem theItem� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 0 constants13_midi_command  � r  ����� m  ����
�� MICONtOn� n      ��� 1  ����
�� 
qMSt� o  ������ 0 newcue newCue� ��� = ����� o  ������ 0 theitem theItem� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 0 constants13_midi_command  � ��� r  ����� m  ����
�� MICONtOf� n      ��� 1  ����
�� 
qMSt� o  ������ 0 newcue newCue� ��� = ���� o  ������ 0 theitem theItem� n  ���� 4  ����
�� 
cobj� m  ���� � o  ������ 0 constants13_midi_command  � ��� r  ��� m  
��
�� MICOPrCh� n      � � 1  ��
�� 
qMSt  o  
���� 0 newcue newCue�  = # o  ���� 0 theitem theItem n  " 4  "��
�� 
cobj m  !����  o  ���� 0 constants13_midi_command   	 r  &1

 m  &)��
�� MICOCtCh n       1  ,0��
�� 
qMSt o  ),���� 0 newcue newCue	  = 4B o  47���� 0 theitem theItem n  7A 4  :A��
�� 
cobj m  =@����  o  7:���� 0 constants13_midi_command    r  EP m  EH��
�� MICOKyPr n       1  KO��
�� 
qMSt o  HK���� 0 newcue newCue  = Sa o  SV���� 0 theitem theItem n  V`  4  Y`��!
�� 
cobj! m  \_����   o  VY���� 0 constants13_midi_command   "��" r  do#$# m  dg��
�� MICOChPr$ n      %&% 1  jn��
�� 
qMSt& o  gj���� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  {�'(' m  {|��
�� boovtrue( o      ���� 0 ohdear ohDear�   index13_midi_command   � �)) *   i n d e x 1 3 _ m i d i _ c o m m a n d��  ��  � *+* l ����������  ��  ��  + ,-, Z  ��./����. > ��010 n  ��232 4  ����4
�� 
cobj4 m  ������ 3 o  ������ 00 propertiestocolumnsref propertiesToColumnsRef1 m  ������  / l ��5675 Q  ��89:8 k  ��;; <=< r  ��>?> n  ��@A@ 4  ����B
�� 
cobjB l ��C����C n  ��DED 4  ����F
�� 
cobjF m  ������ E o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  A o  ������ 0 therecordref theRecordRef? o      ���� 0 theitem theItem= G��G Z  ��HI����H > ��JKJ o  ������ 0 theitem theItemK m  ��LL �MM  I r  ��NON c  ��PQP o  ������ 0 theitem theItemQ m  ����
�� 
longO n      RSR 1  ����
�� 
qMB1S o  ������ 0 newcue newCue��  ��  ��  9 R      ������
�� .ascrerr ****      � ****��  ��  : r  ��TUT m  ����
�� boovtrueU o      ���� 0 ohdear ohDear6   index14_midi_byte_one   7 �VV ,   i n d e x 1 4 _ m i d i _ b y t e _ o n e��  ��  - WXW l ����������  ��  ��  X YZY Z  �4[\����[ > ��]^] n  ��_`_ 4  ���a
� 
cobja m  ���~�~ ` o  ���}�} 00 propertiestocolumnsref propertiesToColumnsRef^ m  ���|�|  \ l �0bcdb Q  �0efge k  �#hh iji r  �klk n  �mnm 4  ��{o
�{ 
cobjo l � p�z�yp n  � qrq 4  ���xs
�x 
cobjs m  ���w�w r o  ���v�v 00 propertiestocolumnsref propertiesToColumnsRef�z  �y  n o  ���u�u 0 therecordref theRecordRefl o      �t�t 0 theitem theItemj t�st Z  #uv�r�qu > wxw o  	�p�p 0 theitem theItemx m  	yy �zz  v r  {|{ c  }~} o  �o�o 0 theitem theItem~ m  �n
�n 
long| n      � 1  �m
�m 
qMB2� o  �l�l 0 newcue newCue�r  �q  �s  f R      �k�j�i
�k .ascrerr ****      � ****�j  �i  g r  +0��� m  +,�h
�h boovtrue� o      �g�g 0 ohdear ohDearc   index15_midi_byte_two   d ��� ,   i n d e x 1 5 _ m i d i _ b y t e _ t w o��  ��  Z ��� l 55�f�e�d�f  �e  �d  � ��� Z  5����c�b� > 5A��� n  5?��� 4  8?�a�
�a 
cobj� m  ;>�`�` � o  58�_�_ 00 propertiestocolumnsref propertiesToColumnsRef� m  ?@�^�^  � l D����� Q  D����� k  G��� ��� r  G]��� n  GY��� 4  JY�]�
�] 
cobj� l MX��\�[� n  MX��� 4  PW�Z�
�Z 
cobj� m  SV�Y�Y � o  MP�X�X 00 propertiestocolumnsref propertiesToColumnsRef�\  �[  � o  GJ�W�W 0 therecordref theRecordRef� o      �V�V 0 theitem theItem� ��U� Z  ^�����T� = ^j��� o  ^a�S�S 0 theitem theItem� n  ai��� 4  di�R�
�R 
cobj� m  gh�Q�Q � o  ad�P�P  0 constants16_timecode_trigger  � r  mx��� m  mp�O
�O YorNYyes� n      ��� 1  sw�N
�N 
qUTC� o  ps�M�M 0 newcue newCue� ��� = {���� o  {~�L�L 0 theitem theItem� n  ~���� 4  ���K�
�K 
cobj� m  ���J�J � o  ~��I�I  0 constants16_timecode_trigger  � ��H� r  ����� m  ���G
�G YorNNnoo� n      ��� 1  ���F
�F 
qUTC� o  ���E�E 0 newcue newCue�H  �T  �U  � R      �D�C�B
�D .ascrerr ****      � ****�C  �B  � r  ����� m  ���A
�A boovtrue� o      �@�@ 0 ohdear ohDear�   index16_timecode_trigger   � ��� 2   i n d e x 1 6 _ t i m e c o d e _ t r i g g e r�c  �b  � ��� l ���?�>�=�?  �>  �=  � ��� Z  � ���<�;� > ����� n  ����� 4  ���:�
�: 
cobj� m  ���9�9 � o  ���8�8 00 propertiestocolumnsref propertiesToColumnsRef� m  ���7�7  � l ����� Q  ����� k  ��� ��� r  ����� n  ����� 4  ���6�
�6 
cobj� l ����5�4� n  ����� 4  ���3�
�3 
cobj� m  ���2�2 � o  ���1�1 00 propertiestocolumnsref propertiesToColumnsRef�5  �4  � o  ���0�0 0 therecordref theRecordRef� o      �/�/ 0 theitem theItem� ��.� Z  �����-� = ����� o  ���,�, 0 theitem theItem� n  ����� 4  ���+�
�+ 
cobj� m  ���*�* � o  ���)�) "0 constants17_wall_clock_trigger  � r  ����� m  ���(
�( YorNYyes� n      ��� 1  ���'
�' 
qUWC� o  ���&�& 0 newcue newCue� ��� = ����� o  ���%�% 0 theitem theItem� n  ����� 4  ���$�
�$ 
cobj� m  ���#�# � o  ���"�" "0 constants17_wall_clock_trigger  � ��!� r   ��� m   � 
�  YorNNnoo� n      ��� 1  
�
� 
qUWC� o  �� 0 newcue newCue�!  �-  �.  � R      ���
� .ascrerr ****      � ****�  �  � r  ��� m  �
� boovtrue� o      �� 0 ohdear ohDear� !  index17_wall_clock_trigger   � ��� 6   i n d e x 1 7 _ w a l l _ c l o c k _ t r i g g e r�<  �;  � ��� l !!����  �  �  � ��� Z  !x����� > !-��� n  !+��� 4  $+� 
� 
cobj  m  '*�� � o  !$�� 00 propertiestocolumnsref propertiesToColumnsRef� m  +,��  � l 0t Q  0t k  3g 	 r  3I

 n  3E 4  6E�
� 
cobj l 9D�� n  9D 4  <C�
� 
cobj m  ?B��  o  9<�
�
 00 propertiestocolumnsref propertiesToColumnsRef�  �   o  36�	�	 0 therecordref theRecordRef o      �� 0 theitem theItem	 � Z  Jg�� > JQ o  JM�� 0 theitem theItem m  MP �   r  Tc c  T[ o  TW�� 0 theitem theItem m  WZ�
� 
long n       1  ^b�
� 
qwcH o  [^� �  0 newcue newCue�  �  �   R      ������
�� .ascrerr ****      � ****��  ��   r  ot !  m  op��
�� boovtrue! o      ���� 0 ohdear ohDear   index18_wall_clock_hours    �"" 2   i n d e x 1 8 _ w a l l _ c l o c k _ h o u r s�  �  � #$# l yy��������  ��  ��  $ %&% Z  y�'(����' > y�)*) n  y�+,+ 4  |���-
�� 
cobj- m  ����� , o  y|���� 00 propertiestocolumnsref propertiesToColumnsRef* m  ������  ( l ��./0. Q  ��1231 k  ��44 565 r  ��787 n  ��9:9 4  ����;
�� 
cobj; l ��<����< n  ��=>= 4  ����?
�� 
cobj? m  ������ > o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  : o  ������ 0 therecordref theRecordRef8 o      ���� 0 theitem theItem6 @��@ Z  ��AB����A > ��CDC o  ������ 0 theitem theItemD m  ��EE �FF  B r  ��GHG c  ��IJI o  ������ 0 theitem theItemJ m  ����
�� 
longH n      KLK 1  ����
�� 
qwcML o  ������ 0 newcue newCue��  ��  ��  2 R      ������
�� .ascrerr ****      � ****��  ��  3 r  ��MNM m  ����
�� boovtrueN o      ���� 0 ohdear ohDear/ !  index19_wall_clock_minutes   0 �OO 6   i n d e x 1 9 _ w a l l _ c l o c k _ m i n u t e s��  ��  & PQP l ����������  ��  ��  Q RSR Z  �(TU����T > ��VWV n  ��XYX 4  ����Z
�� 
cobjZ m  ������ Y o  ������ 00 propertiestocolumnsref propertiesToColumnsRefW m  ������  U l �$[\][ Q  �$^_`^ k  �aa bcb r  ��ded n  ��fgf 4  ����h
�� 
cobjh l ��i����i n  ��jkj 4  ����l
�� 
cobjl m  ������ k o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  g o  ������ 0 therecordref theRecordRefe o      ���� 0 theitem theItemc m��m Z  �no����n > �pqp o  ������ 0 theitem theItemq m  � rr �ss  o r  tut c  vwv o  ���� 0 theitem theItemw m  
��
�� 
longu n      xyx 1  ��
�� 
qwcSy o  ���� 0 newcue newCue��  ��  ��  _ R      ������
�� .ascrerr ****      � ****��  ��  ` r  $z{z m   ��
�� boovtrue{ o      ���� 0 ohdear ohDear\ !  index20_wall_clock_seconds   ] �|| 6   i n d e x 2 0 _ w a l l _ c l o c k _ s e c o n d s��  ��  S }~} l ))��������  ��  ��  ~ � Z  )������� F  )C��� E )0��� o  ),���� 0 index21_mode  � o  ,/���� 0 thetype theType� > 3?��� n  3=��� 4  6=���
�� 
cobj� m  9<���� � o  36���� 00 propertiestocolumnsref propertiesToColumnsRef� m  =>����  � Q  F���� k  I��� ��� r  I_��� n  I[��� 4  L[���
�� 
cobj� l OZ������ n  OZ��� 4  RY���
�� 
cobj� m  UX���� � o  OR���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  IL���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  `������� = `l��� o  `c���� 0 theitem theItem� n  ck��� 4  fk���
�� 
cobj� m  ij���� � o  cf���� 0 constants21_mode  � r  oz��� m  or��
�� GRUPqGCL� n      ��� 1  uy��
�� 
qGMo� o  ru���� 0 newcue newCue� ��� = }���� o  }����� 0 theitem theItem� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 0 constants21_mode  � ��� r  ����� m  ����
�� GRUPqGSS� n      ��� 1  ����
�� 
qGMo� o  ������ 0 newcue newCue� ��� = ����� o  ������ 0 theitem theItem� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 0 constants21_mode  � ��� r  ����� m  ����
�� GRUPqGHS� n      ��� 1  ����
�� 
qGMo� o  ������ 0 newcue newCue� ��� = ����� o  ������ 0 theitem theItem� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 0 constants21_mode  � ��� r  ����� m  ����
�� GRUPqGFA� n      ��� 1  ����
�� 
qGMo� o  ������ 0 newcue newCue� ��� = ����� o  ������ 0 theitem theItem� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 0 constants21_mode  � ���� r  ����� m  ����
�� GRUPqGFR� n      ��� 1  ����
�� 
qGMo� o  ������ 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  ���� m  ����
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  � ��� l ����~��  �  �~  � ��� Z  ����}�|� F  "��� E ��� o  �{�{ 0 index22_sync_to_timecode  � o  �z�z 0 thetype theType� > ��� n  ��� 4  �y�
�y 
cobj� m  �x�x � o  �w�w 00 propertiestocolumnsref propertiesToColumnsRef� m  �v�v  � Q  %����� k  (z�� ��� r  (>��� n  (:��� 4  +:�u�
�u 
cobj� l .9��t�s� n  .9��� 4  18�r�
�r 
cobj� m  47�q�q � o  .1�p�p 00 propertiestocolumnsref propertiesToColumnsRef�t  �s  � o  (+�o�o 0 therecordref theRecordRef� o      �n�n 0 theitem theItem� ��m� Z  ?z����l� = ?K� � o  ?B�k�k 0 theitem theItem  n  BJ 4  EJ�j
�j 
cobj m  HI�i�i  o  BE�h�h  0 constants22_sync_to_timecode  � r  NY m  NQ�g
�g YorNYyes n       1  TX�f
�f 
qSTC o  QT�e�e 0 newcue newCue� 	 = \h

 o  \_�d�d 0 theitem theItem n  _g 4  bg�c
�c 
cobj m  ef�b�b  o  _b�a�a  0 constants22_sync_to_timecode  	 �` r  kv m  kn�_
�_ YorNNnoo n       1  qu�^
�^ 
qSTC o  nq�]�] 0 newcue newCue�`  �l  �m  � R      �\�[�Z
�\ .ascrerr ****      � ****�[  �Z  � r  �� m  ���Y
�Y boovtrue o      �X�X 0 ohdear ohDear�}  �|  �  l ���W�V�U�W  �V  �U    Z  ��T�S F  �� E �� o  ���R�R 0 index23_sync_mode   o  ���Q�Q 0 thetype theType > �� !  n  ��"#" 4  ���P$
�P 
cobj$ m  ���O�O # o  ���N�N 00 propertiestocolumnsref propertiesToColumnsRef! m  ���M�M   Q  �%&'% k  ��(( )*) r  ��+,+ n  ��-.- 4  ���L/
�L 
cobj/ l ��0�K�J0 n  ��121 4  ���I3
�I 
cobj3 m  ���H�H 2 o  ���G�G 00 propertiestocolumnsref propertiesToColumnsRef�K  �J  . o  ���F�F 0 therecordref theRecordRef, o      �E�E 0 theitem theItem* 4�D4 Z  ��567�C5 = ��898 o  ���B�B 0 theitem theItem9 n  ��:;: 4  ���A<
�A 
cobj< m  ���@�@ ; o  ���?�? 0 constants23_sync_mode  6 r  ��=>= m  ���>
�> MTLTsynM> n      ?@? 1  ���=
�= 
qSMo@ o  ���<�< 0 newcue newCue7 ABA = ��CDC o  ���;�; 0 theitem theItemD n  ��EFE 4  ���:G
�: 
cobjG m  ���9�9 F o  ���8�8 0 constants23_sync_mode  B H�7H r  ��IJI m  ���6
�6 MTLTsynLJ n      KLK 1  ���5
�5 
qSMoL o  ���4�4 0 newcue newCue�7  �C  �D  & R      �3�2�1
�3 .ascrerr ****      � ****�2  �1  ' r  MNM m  �0
�0 boovtrueN o      �/�/ 0 ohdear ohDear�T  �S   OPO l �.�-�,�.  �-  �,  P QRQ Z  �ST�+�*S F  *UVU E WXW o  �)�) 0 index24_smpte_format  X o  �(�( 0 thetype theTypeV > &YZY n  $[\[ 4  $�']
�' 
cobj] m   #�&�& \ o  �%�% 00 propertiestocolumnsref propertiesToColumnsRefZ m  $%�$�$  T Q  -�^_`^ k  0�aa bcb r  0Fded n  0Bfgf 4  3B�#h
�# 
cobjh l 6Ai�"�!i n  6Ajkj 4  9@� l
�  
cobjl m  <?�� k o  69�� 00 propertiestocolumnsref propertiesToColumnsRef�"  �!  g o  03�� 0 therecordref theRecordRefe o      �� 0 theitem theItemc m�m Z  G�nop�n = GSqrq o  GJ�� 0 theitem theItemr n  JRsts 4  MR�u
� 
cobju m  PQ�� t o  JM�� 0 constants24_smpte_format  o r  Vavwv m  VY�
� SMPTtfFPw n      xyx 1  \`�
� 
qSMPy o  Y\�� 0 newcue newCuep z{z = dp|}| o  dg�� 0 theitem theItem} n  go~~ 4  jo��
� 
cobj� m  mn��  o  gj�� 0 constants24_smpte_format  { ��� r  s~��� m  sv�
� SMPTtiFP� n      ��� 1  y}�
� 
qSMP� o  vy�� 0 newcue newCue� ��� = ����� o  ���� 0 theitem theItem� n  ����� 4  ���
�
�
 
cobj� m  ���	�	 � o  ���� 0 constants24_smpte_format  � ��� r  ����� m  ���
� SMPTthDR� n      ��� 1  ���
� 
qSMP� o  ���� 0 newcue newCue� ��� = ����� o  ���� 0 theitem theItem� n  ����� 4  ����
� 
cobj� m  ���� � o  ���� 0 constants24_smpte_format  � �� � r  ����� m  ����
�� SMPTthND� n      ��� 1  ����
�� 
qSMP� o  ������ 0 newcue newCue�   �  �  _ R      ������
�� .ascrerr ****      � ****��  ��  ` r  ����� m  ����
�� boovtrue� o      ���� 0 ohdear ohDear�+  �*  R ��� l ����������  ��  ��  � ��� Z  �1������� F  ����� E ����� o  ������  0 index25_mtc_sync_source_name  � o  ������ 0 thetype theType� > ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef� m  ������  � Q  �-���� k  � �� ��� r  ���� n  ���� 4  ����
�� 
cobj� l ������� n  ���� 4  � ���
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ������ 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z   ������� > ��� o  
���� 0 theitem theItem� m  
�� ���  � r  ��� o  ���� 0 theitem theItem� n      ��� 1  ��
�� 
qMTN� o  ���� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  (-��� m  ()��
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  � ��� l 22��������  ��  ��  � ��� Z  2�������� F  2L��� E 29��� o  25���� 0 index26_ltc_sync_channel  � o  58���� 0 thetype theType� > <H��� n  <F��� 4  ?F���
�� 
cobj� m  BE���� � o  <?���� 00 propertiestocolumnsref propertiesToColumnsRef� m  FG����  � Q  O����� k  R��� ��� r  Rh��� n  Rd��� 4  Ud���
�� 
cobj� l Xc������ n  Xc��� 4  [b���
�� 
cobj� m  ^a���� � o  X[���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  RU���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  i�������� > ip��� o  il���� 0 theitem theItem� m  lo�� ���  � r  s���� c  sz��� o  sv���� 0 theitem theItem� m  vy��
�� 
long� n      ��� 1  }���
�� 
qLTC� o  z}���� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  ����� m  ����
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  � ��� l ����������  ��  ��  � ��� Z  ��������� F  ��   E �� o  ������ 0 index27_patch   o  ������ 0 thetype theType > �� n  �� 4  ����
�� 
cobj m  ������  o  ������ 00 propertiestocolumnsref propertiesToColumnsRef m  ������  � Q  ��	
	 k  ��  r  �� n  �� 4  ����
�� 
cobj l ������ n  �� 4  ����
�� 
cobj m  ������  o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��   o  ������ 0 therecordref theRecordRef o      ���� 0 theitem theItem �� Z  ������ > �� o  ������ 0 theitem theItem m  �� �   r  ��  c  ��!"! o  ������ 0 theitem theItem" m  ����
�� 
long  n      #$# 1  ����
�� 
qPch$ o  ������ 0 newcue newCue��  ��  ��  
 R      ������
�� .ascrerr ****      � ****��  ��   r  ��%&% m  ����
�� boovtrue& o      ���� 0 ohdear ohDear��  ��  � '(' l ����������  ��  ��  ( )*) Z  �c+,����+ F  �-.- E �/0/ o  ����� 0 index28_start_time  0 o  ���� 0 thetype theType. > 121 n  343 4  ��5
�� 
cobj5 m  ���� 4 o  ���� 00 propertiestocolumnsref propertiesToColumnsRef2 m  ����  , Q  _6786 k  R99 :;: r  4<=< n  0>?> 4  !0��@
�� 
cobj@ l $/A����A n  $/BCB 4  '.��D
�� 
cobjD m  *-���� C o  $'���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  ? o  !���� 0 therecordref theRecordRef= o      ���� 0 theitem theItem; E��E Z  5RFG����F > 5<HIH o  58���� 0 theitem theItemI m  8;JJ �KK  G r  ?NLML c  ?FNON o  ?B���� 0 theitem theItemO m  BE��
�� 
doubM n      PQP 1  IM�
� 
qStaQ o  FI�~�~ 0 newcue newCue��  ��  ��  7 R      �}�|�{
�} .ascrerr ****      � ****�|  �{  8 r  Z_RSR m  Z[�z
�z boovtrueS o      �y�y 0 ohdear ohDear��  ��  * TUT l dd�x�w�v�x  �w  �v  U VWV l dd�u�t�s�u  �t  �s  W XYX Z  d�Z[�r�qZ F  d~\]\ E dk^_^ o  dg�p�p 0 index29_end_time  _ o  gj�o�o 0 thetype theType] > nz`a` n  nxbcb 4  qx�nd
�n 
cobjd m  tw�m�m c o  nq�l�l 00 propertiestocolumnsref propertiesToColumnsRefa m  xy�k�k  [ Q  ��efge k  ��hh iji r  ��klk n  ��mnm 4  ���jo
�j 
cobjo l ��p�i�hp n  ��qrq 4  ���gs
�g 
cobjs m  ���f�f r o  ���e�e 00 propertiestocolumnsref propertiesToColumnsRef�i  �h  n o  ���d�d 0 therecordref theRecordRefl o      �c�c 0 theitem theItemj t�bt Z  ��uv�a�`u > ��wxw o  ���_�_ 0 theitem theItemx m  ��yy �zz  v r  ��{|{ c  ��}~} o  ���^�^ 0 theitem theItem~ m  ���]
�] 
doub| n      � 1  ���\
�\ 
qEnd� o  ���[�[ 0 newcue newCue�a  �`  �b  f R      �Z�Y�X
�Z .ascrerr ****      � ****�Y  �X  g r  ����� m  ���W
�W boovtrue� o      �V�V 0 ohdear ohDear�r  �q  Y ��� l  ���U���U  �rl
                    if theType is in index30_loop_start_time and item 30 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 30 of propertiesToColumnsRef) of theRecordRef
                            if theItem is not "" then
                                set loop start time of newCue to theItem as real
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if

                    if theType is in index31_loop_end_time and item 31 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 31 of propertiesToColumnsRef) of theRecordRef
                            if theItem is not "" then
                                set loop end time of newCue to theItem as real
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
 
                    if theType is in index32_loop_count and item 32 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 32 of propertiesToColumnsRef) of theRecordRef
                            if theItem is not "" then
                                set loop count of newCue to theItem as integer
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
    � ���� 
                                         i f   t h e T y p e   i s   i n   i n d e x 3 0 _ l o o p _ s t a r t _ t i m e   a n d   i t e m   3 0   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   3 0   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   n o t   " "   t h e n 
                                                                 s e t   l o o p   s t a r t   t i m e   o f   n e w C u e   t o   t h e I t e m   a s   r e a l 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
 
                                         i f   t h e T y p e   i s   i n   i n d e x 3 1 _ l o o p _ e n d _ t i m e   a n d   i t e m   3 1   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   3 1   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   n o t   " "   t h e n 
                                                                 s e t   l o o p   e n d   t i m e   o f   n e w C u e   t o   t h e I t e m   a s   r e a l 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
   
                                         i f   t h e T y p e   i s   i n   i n d e x 3 2 _ l o o p _ c o u n t   a n d   i t e m   3 2   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   3 2   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   n o t   " "   t h e n 
                                                                 s e t   l o o p   c o u n t   o f   n e w C u e   t o   t h e I t e m   a s   i n t e g e r 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
  � ��� l ���T�S�R�T  �S  �R  � ��� Z  �I���Q�P� F  ����� E ����� o  ���O�O 0 index33_infinite_loop  � o  ���N�N 0 thetype theType� > ����� n  ����� 4  ���M�
�M 
cobj� m  ���L�L !� o  ���K�K 00 propertiestocolumnsref propertiesToColumnsRef� m  ���J�J  � Q  �E���� k  �8�� ��� r  � ��� n  ����� 4  ���I�
�I 
cobj� l ����H�G� n  ����� 4  ���F�
�F 
cobj� m  ���E�E !� o  ���D�D 00 propertiestocolumnsref propertiesToColumnsRef�H  �G  � o  ���C�C 0 therecordref theRecordRef� o      �B�B 0 theitem theItem� ��A� Z  8����@� = ��� o  �?�? 0 theitem theItem� n  ��� 4  �>�
�> 
cobj� m  
�=�= � o  �<�< 0 constants33_infinite_loop  � r  ��� m  �;
�; boovtrue� n      ��� 1  �:
�: 
qInf� o  �9�9 0 newcue newCue� ��� = (��� o  �8�8 0 theitem theItem� n  '��� 4  "'�7�
�7 
cobj� m  %&�6�6 � o  "�5�5 0 constants33_infinite_loop  � ��4� r  +4��� m  +,�3
�3 boovfals� n      ��� 1  /3�2
�2 
qInf� o  ,/�1�1 0 newcue newCue�4  �@  �A  � R      �0�/�.
�0 .ascrerr ****      � ****�/  �.  � r  @E��� m  @A�-
�- boovtrue� o      �,�, 0 ohdear ohDear�Q  �P  � ��� l  JJ�+���+  ���
                    if theType is in index34_guarantee_sync and item 34 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 34 of propertiesToColumnsRef) of theRecordRef
                            if theItem is item 1 of constants34_guarantee_sync then
                                set guarantee sync of newCue to true
                            else if theItem is item 2 of constants34_guarantee_sync then
                                set guarantee sync of newCue to false
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
    � ���� 
                                         i f   t h e T y p e   i s   i n   i n d e x 3 4 _ g u a r a n t e e _ s y n c   a n d   i t e m   3 4   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   3 4   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   i t e m   1   o f   c o n s t a n t s 3 4 _ g u a r a n t e e _ s y n c   t h e n 
                                                                 s e t   g u a r a n t e e   s y n c   o f   n e w C u e   t o   t r u e 
                                                         e l s e   i f   t h e I t e m   i s   i t e m   2   o f   c o n s t a n t s 3 4 _ g u a r a n t e e _ s y n c   t h e n 
                                                                 s e t   g u a r a n t e e   s y n c   o f   n e w C u e   t o   f a l s e 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
  � ��� Z  J����*�)� F  Jd��� E JQ��� o  JM�(�( 0 index35_integrated_fade  � o  MP�'�' 0 thetype theType� > T`��� n  T^��� 4  W^�&�
�& 
cobj� m  Z]�%�% #� o  TW�$�$ 00 propertiestocolumnsref propertiesToColumnsRef� m  ^_�#�#  � Q  g����� k  j��� ��� r  j���� n  j|��� 4  m|�"�
�" 
cobj� l p{��!� � n  p{��� 4  sz��
� 
cobj� m  vy�� #� o  ps�� 00 propertiestocolumnsref propertiesToColumnsRef�!  �   � o  jm�� 0 therecordref theRecordRef� o      �� 0 theitem theItem� ��� Z  ������� = ����� o  ���� 0 theitem theItem� n  ����� 4  ����
� 
cobj� m  ���� � o  ���� 0 constants35_integrated_fade  � r  ����� m  ���
� YorNYyes� n      ��� 1  ���
� 
qIFa� o  ���� 0 newcue newCue� ��� = ����� o  ���� 0 theitem theItem� n  ����� 4  ����
� 
cobj� m  ���� � o  ���� 0 constants35_integrated_fade  � ��� r  ����� m  ���
� YorNNnoo� n      ��� 1  ���
� 
qIFa� o  ���
�
 0 newcue newCue�  �  �  � R      �	��
�	 .ascrerr ****      � ****�  �  � r  ����� m  ���
� boovtrue� o      �� 0 ohdear ohDear�*  �)  � ��� l ������  �  �  � � � Z  �Q��  F  �� E �� o  ������ 0 index36_fade_mode   o  ������ 0 thetype theType > �� n  ��	
	 4  ����
�� 
cobj m  ������ $
 o  ������ 00 propertiestocolumnsref propertiesToColumnsRef m  ������   Q  �M k  �@  r  � n  �  4  � ��
�� 
cobj l ������ n  �� 4  ����
�� 
cobj m  ������ $ o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��   o  ������ 0 therecordref theRecordRef o      ���� 0 theitem theItem �� Z  @�� =   o  ���� 0 theitem theItem  n  !"! 4  ��#
�� 
cobj# m  ���� " o  ���� 0 constants36_fade_mode   r  $%$ m  ��
�� ABREABSO% n      &'& 1  ��
�� 
qAbs' o  ���� 0 newcue newCue ()( = ".*+* o  "%���� 0 theitem theItem+ n  %-,-, 4  (-��.
�� 
cobj. m  +,���� - o  %(���� 0 constants36_fade_mode  ) /��/ r  1<010 m  14��
�� ABRERELA1 n      232 1  7;��
�� 
qAbs3 o  47���� 0 newcue newCue��  ��  ��   R      ������
�� .ascrerr ****      � ****��  ��   r  HM454 m  HI��
�� boovtrue5 o      ���� 0 ohdear ohDear�  �     676 l RR��������  ��  ��  7 898 Z  R�:;����: F  Rl<=< E RY>?> o  RU���� !0 index37_stop_target_when_done  ? o  UX���� 0 thetype theType= > \h@A@ n  \fBCB 4  _f��D
�� 
cobjD m  be���� %C o  \_���� 00 propertiestocolumnsref propertiesToColumnsRefA m  fg����  ; Q  o�EFGE k  r�HH IJI r  r�KLK n  r�MNM 4  u���O
�� 
cobjO l x�P����P n  x�QRQ 4  {���S
�� 
cobjS m  ~����� %R o  x{���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  N o  ru���� 0 therecordref theRecordRefL o      ���� 0 theitem theItemJ T��T Z  ��UVW��U = ��XYX o  ������ 0 theitem theItemY n  ��Z[Z 4  ����\
�� 
cobj\ m  ������ [ o  ������ %0 !constants37_stop_target_when_done  V r  ��]^] m  ����
�� boovtrue^ n      _`_ 1  ����
�� 
qAuS` o  ������ 0 newcue newCueW aba = ��cdc o  ������ 0 theitem theItemd n  ��efe 4  ����g
�� 
cobjg m  ������ f o  ������ %0 !constants37_stop_target_when_done  b h��h r  ��iji m  ����
�� boovfalsj n      klk 1  ����
�� 
qAuSl o  ������ 0 newcue newCue��  ��  ��  F R      ������
�� .ascrerr ****      � ****��  ��  G r  ��mnm m  ����
�� boovtruen o      ���� 0 ohdear ohDear��  ��  9 opo l  ����qr��  q��
                    if theType is in index38_auto_stop and item 38 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 38 of propertiesToColumnsRef) of theRecordRef
                            if theItem is item 1 of constants38_auto_stop then
                                set auto stop of newCue to true
                            else if theItem is item 2 of constants38_auto_stop then
                                set auto stop of newCue to false
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
    r �ss~ 
                                         i f   t h e T y p e   i s   i n   i n d e x 3 8 _ a u t o _ s t o p   a n d   i t e m   3 8   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   3 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   i t e m   1   o f   c o n s t a n t s 3 8 _ a u t o _ s t o p   t h e n 
                                                                 s e t   a u t o   s t o p   o f   n e w C u e   t o   t r u e 
                                                         e l s e   i f   t h e I t e m   i s   i t e m   2   o f   c o n s t a n t s 3 8 _ a u t o _ s t o p   t h e n 
                                                                 s e t   a u t o   s t o p   o f   n e w C u e   t o   f a l s e 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
  p tut Z  �7vw����v F  ��xyx E ��z{z o  ������ 0 index39_layer  { o  ������ 0 thetype theTypey > ��|}| n  ��~~ 4  �����
�� 
cobj� m  ������ ' o  ������ 00 propertiestocolumnsref propertiesToColumnsRef} m  ������  w Q  �3���� k  �&�� ��� r  ���� n  ���� 4  ����
�� 
cobj� l ������� n  ���� 4  ����
�� 
cobj� m  ����� '� o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ������ 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  	&������� > 	��� o  	���� 0 theitem theItem� m  �� ���  � r  "��� c  ��� o  ���� 0 theitem theItem� m  ��
�� 
long� n      ��� 1  !��
�� 
qLay� o  ���� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  .3��� m  ./��
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  u ��� l 88��������  ��  ��  � ��� Z  8�������� F  8R��� E 8?��� o  8;���� 0 index40_full_screen  � o  ;>���� 0 thetype theType� > BN��� n  BL��� 4  EL���
�� 
cobj� m  HK���� (� o  BE���� 00 propertiestocolumnsref propertiesToColumnsRef� m  LM����  � Q  U����� k  X��� ��� r  Xn��� n  Xj��� 4  [j���
�� 
cobj� l ^i������ n  ^i��� 4  ah���
�� 
cobj� m  dg���� (� o  ^a���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  X[���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  o������� = o{��� o  or�� 0 theitem theItem� n  rz��� 4  uz�~�
�~ 
cobj� m  xy�}�} � o  ru�|�| 0 constants40_full_screen  � r  ~���� m  ~�{
�{ boovtrue� n      ��� 1  ���z
�z 
qFSc� o  ��y�y 0 newcue newCue� ��� = ����� o  ���x�x 0 theitem theItem� n  ����� 4  ���w�
�w 
cobj� m  ���v�v � o  ���u�u 0 constants40_full_screen  � ��t� r  ����� m  ���s
�s boovfals� n      ��� 1  ���r
�r 
qFSc� o  ���q�q 0 newcue newCue�t  ��  ��  � R      �p�o�n
�p .ascrerr ****      � ****�o  �n  � r  ����� m  ���m
�m boovtrue� o      �l�l 0 ohdear ohDear��  ��  � ��� l ���k�j�i�k  �j  �i  � ��� Z  � 7���h�g� F  ����� E ����� o  ���f�f !0 index41_preserve_aspect_ratio  � o  ���e�e 0 thetype theType� > ����� n  ����� 4  ���d�
�d 
cobj� m  ���c�c )� o  ���b�b 00 propertiestocolumnsref propertiesToColumnsRef� m  ���a�a  � Q  � 3���� k  � &�� ��� r  ����� n  ����� 4  ���`�
�` 
cobj� l ����_�^� n  ����� 4  ���]�
�] 
cobj� m  ���\�\ )� o  ���[�[ 00 propertiestocolumnsref propertiesToColumnsRef�_  �^  � o  ���Z�Z 0 therecordref theRecordRef� o      �Y�Y 0 theitem theItem� ��X� Z  � &����W� = ����� o  ���V�V 0 theitem theItem� n  ����� 4  ���U�
�U 
cobj� m  ���T�T � o  ���S�S %0 !constants41_preserve_aspect_ratio  � r  � � � m  ���R
�R boovtrue  n       1    �Q
�Q 
qPAs o  � �P�P 0 newcue newCue�  =  
  o   
 �O�O 0 theitem theItem n     4    �N	
�N 
cobj	 m    �M�M  o    �L�L %0 !constants41_preserve_aspect_ratio   
�K
 r    " m    �J
�J boovfals n       1    !�I
�I 
qPAs o    �H�H 0 newcue newCue�K  �W  �X  � R      �G�F�E
�G .ascrerr ****      � ****�F  �E  � r   . 3 m   . /�D
�D boovtrue o      �C�C 0 ohdear ohDear�h  �g  �  l  8 8�B�A�@�B  �A  �@    Z   8 ��?�> F   8 R E  8 ? o   8 ;�=�= 0 index42_opacity   o   ; >�<�< 0 thetype theType >  B N n   B L 4   E L�;
�; 
cobj m   H K�:�: * o   B E�9�9 00 propertiestocolumnsref propertiesToColumnsRef m   L M�8�8   Q   U � !"  k   X �## $%$ r   X n&'& n   X j()( 4   [ j�7*
�7 
cobj* l  ^ i+�6�5+ n   ^ i,-, 4   a h�4.
�4 
cobj. m   d g�3�3 *- o   ^ a�2�2 00 propertiestocolumnsref propertiesToColumnsRef�6  �5  ) o   X [�1�1 0 therecordref theRecordRef' o      �0�0 0 theitem theItem% /�// Z   o �01�.�-0 >  o v232 o   o r�,�, 0 theitem theItem3 m   r u44 �55  1 r   y �676 c   y �898 o   y |�+�+ 0 theitem theItem9 m   | �*
�* 
doub7 n      :;: 1   � ��)
�) 
qOpa; o   � ��(�( 0 newcue newCue�.  �-  �/  ! R      �'�&�%
�' .ascrerr ****      � ****�&  �%  " r   � �<=< m   � ��$
�$ boovtrue= o      �#�# 0 ohdear ohDear�?  �>   >?> l  � ��"�!� �"  �!  �   ? @A@ Z   �!BC��B F   � �DED E  � �FGF o   � ��� 0 index43_translation_x  G o   � ��� 0 thetype theTypeE >  � �HIH n   � �JKJ 4   � ��L
� 
cobjL m   � ��� +K o   � ��� 00 propertiestocolumnsref propertiesToColumnsRefI m   � ���  C Q   � �MNOM k   � �PP QRQ r   � �STS n   � �UVU 4   � ��W
� 
cobjW l  � �X��X n   � �YZY 4   � ��[
� 
cobj[ m   � ��� +Z o   � ��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  V o   � ��� 0 therecordref theRecordRefT o      �� 0 theitem theItemR \�\ Z   � �]^��] >  � �_`_ o   � ��� 0 theitem theItem` m   � �aa �bb  ^ r   � �cdc c   � �efe o   � ��� 0 theitem theItemf m   � ��

�
 
doubd n      ghg 1   � ��	
�	 
qTrXh o   � ��� 0 newcue newCue�  �  �  N R      ���
� .ascrerr ****      � ****�  �  O r   � �iji m   � ��
� boovtruej o      �� 0 ohdear ohDear�  �  A klk l !!��� �  �  �   l mnm Z  !!iop����o F  !!qrq E !!sts o  !!���� 0 index44_translation_y  t o  !!
���� 0 thetype theTyper > !!uvu n  !!wxw 4  !!��y
�� 
cobjy m  !!���� ,x o  !!���� 00 propertiestocolumnsref propertiesToColumnsRefv m  !!����  p Q  !!!ez{|z k  !$!X}} ~~ r  !$!:��� n  !$!6��� 4  !'!6���
�� 
cobj� l !*!5������ n  !*!5��� 4  !-!4���
�� 
cobj� m  !0!3���� ,� o  !*!-���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  !$!'���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem ���� Z  !;!X������� > !;!B��� o  !;!>���� 0 theitem theItem� m  !>!A�� ���  � r  !E!T��� c  !E!L��� o  !E!H���� 0 theitem theItem� m  !H!K��
�� 
doub� n      ��� 1  !O!S��
�� 
qTrY� o  !L!O���� 0 newcue newCue��  ��  ��  { R      ������
�� .ascrerr ****      � ****��  ��  | r  !`!e��� m  !`!a��
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  n ��� l !j!j��������  ��  ��  � ��� Z  !j!�������� F  !j!���� E !j!q��� o  !j!m���� 0 index45_rotation  � o  !m!p���� 0 thetype theType� > !t!���� n  !t!~��� 4  !w!~���
�� 
cobj� m  !z!}���� -� o  !t!w���� 00 propertiestocolumnsref propertiesToColumnsRef� m  !~!����  � Q  !�!����� k  !�!��� ��� r  !�!���� n  !�!���� 4  !�!����
�� 
cobj� l !�!������� n  !�!���� 4  !�!����
�� 
cobj� m  !�!����� -� o  !�!����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  !�!����� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  !�!�������� > !�!���� o  !�!����� 0 theitem theItem� m  !�!��� ���  � r  !�!���� c  !�!���� o  !�!����� 0 theitem theItem� m  !�!���
�� 
doub� n      ��� 1  !�!���
�� 
qRot� o  !�!����� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  !�!���� m  !�!���
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  � ��� l !�!���������  ��  ��  � ��� Z  !�"5������� F  !�!���� E !�!���� o  !�!����� 0 index46_scale_x  � o  !�!����� 0 thetype theType� > !�!���� n  !�!���� 4  !�!����
�� 
cobj� m  !�!����� .� o  !�!����� 00 propertiestocolumnsref propertiesToColumnsRef� m  !�!�����  � Q  !�"1���� k  !�"$�� ��� r  !�"��� n  !�"��� 4  !�"���
�� 
cobj� l !�"������ n  !�"��� 4  !�" ���
�� 
cobj� m  !�!����� .� o  !�!����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  !�!����� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  ""$������� > ""��� o  ""
���� 0 theitem theItem� m  "
"�� ���  � r  "" ��� c  ""��� o  ""���� 0 theitem theItem� m  ""��
�� 
doub� n      ��� 1  ""��
�� 
qScX� o  ""���� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  ","1��� m  ","-��
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  � ��� l "6"6��������  ��  ��  � ��� Z  "6"�������� F  "6"P��� E "6"=��� o  "6"9���� 0 index47_scale_y  � o  "9"<���� 0 thetype theType� > "@"L��� n  "@"J��� 4  "C"J�� 
�� 
cobj  m  "F"I���� /� o  "@"C���� 00 propertiestocolumnsref propertiesToColumnsRef� m  "J"K����  � Q  "S"� k  "V"�  r  "V"l n  "V"h	
	 4  "Y"h��
�� 
cobj l "\"g���� n  "\"g 4  "_"f��
�� 
cobj m  "b"e���� / o  "\"_���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  
 o  "V"Y���� 0 therecordref theRecordRef o      ���� 0 theitem theItem �� Z  "m"����� > "m"t o  "m"p���� 0 theitem theItem m  "p"s �   r  "w"� c  "w"~ o  "w"z���� 0 theitem theItem m  "z"}��
�� 
doub n       1  "�"���
�� 
qScY o  "~"����� 0 newcue newCue��  ��  ��   R      ������
�� .ascrerr ****      � ****��  ��   r  "�"� m  "�"���
�� boovtrue o      ���� 0 ohdear ohDear��  ��  �   l  "�"���!"��  !��
                    if theType is in index48_scale_locked and item 48 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 48 of propertiesToColumnsRef) of theRecordRef
                            if theItem is item 1 of constants48_scale_locked then
                                set scale locked of newCue to true
                            else if theItem is item 2 of constants48_scale_locked then
                                set scale locked of newCue to false
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
 
                    if theType is in index49_custom_rendering and item 49 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 49 of propertiesToColumnsRef) of theRecordRef
                            if theItem is item 1 of constants49_custom_rendering then
                                set custom rendering of newCue to true
                            else if theItem is item 2 of constants49_custom_rendering then
                                set custom rendering of newCue to false
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
    " �##` 
                                         i f   t h e T y p e   i s   i n   i n d e x 4 8 _ s c a l e _ l o c k e d   a n d   i t e m   4 8   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   4 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   i t e m   1   o f   c o n s t a n t s 4 8 _ s c a l e _ l o c k e d   t h e n 
                                                                 s e t   s c a l e   l o c k e d   o f   n e w C u e   t o   t r u e 
                                                         e l s e   i f   t h e I t e m   i s   i t e m   2   o f   c o n s t a n t s 4 8 _ s c a l e _ l o c k e d   t h e n 
                                                                 s e t   s c a l e   l o c k e d   o f   n e w C u e   t o   f a l s e 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
   
                                         i f   t h e T y p e   i s   i n   i n d e x 4 9 _ c u s t o m _ r e n d e r i n g   a n d   i t e m   4 9   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   4 9   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   i t e m   1   o f   c o n s t a n t s 4 9 _ c u s t o m _ r e n d e r i n g   t h e n 
                                                                 s e t   c u s t o m   r e n d e r i n g   o f   n e w C u e   t o   t r u e 
                                                         e l s e   i f   t h e I t e m   i s   i t e m   2   o f   c o n s t a n t s 4 9 _ c u s t o m _ r e n d e r i n g   t h e n 
                                                                 s e t   c u s t o m   r e n d e r i n g   o f   n e w C u e   t o   f a l s e 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
    $%$ Z  "�#&'����& F  "�"�()( E "�"�*+* o  "�"��� 0 index50_do_opacity  + o  "�"��~�~ 0 thetype theType) > "�"�,-, n  "�"�./. 4  "�"��}0
�} 
cobj0 m  "�"��|�| 2/ o  "�"��{�{ 00 propertiestocolumnsref propertiesToColumnsRef- m  "�"��z�z  ' Q  "�#1231 k  "�#
44 565 r  "�"�787 n  "�"�9:9 4  "�"��y;
�y 
cobj; l "�"�<�x�w< n  "�"�=>= 4  "�"��v?
�v 
cobj? m  "�"��u�u 2> o  "�"��t�t 00 propertiestocolumnsref propertiesToColumnsRef�x  �w  : o  "�"��s�s 0 therecordref theRecordRef8 o      �r�r 0 theitem theItem6 @�q@ Z  "�#
ABC�pA = "�"�DED o  "�"��o�o 0 theitem theItemE n  "�"�FGF 4  "�"��nH
�n 
cobjH m  "�"��m�m G o  "�"��l�l 0 constants50_do_opacity  B r  "�"�IJI m  "�"��k
�k boovtrueJ n      KLK 1  "�"��j
�j 
qDoOL o  "�"��i�i 0 newcue newCueC MNM = "�"�OPO o  "�"��h�h 0 theitem theItemP n  "�"�QRQ 4  "�"��gS
�g 
cobjS m  "�"��f�f R o  "�"��e�e 0 constants50_do_opacity  N T�dT r  "�#UVU m  "�"��c
�c boovfalsV n      WXW 1  ##�b
�b 
qDoOX o  "�#�a�a 0 newcue newCue�d  �p  �q  2 R      �`�_�^
�` .ascrerr ****      � ****�_  �^  3 r  ##YZY m  ##�]
�] boovtrueZ o      �\�\ 0 ohdear ohDear��  ��  % [\[ l ##�[�Z�Y�[  �Z  �Y  \ ]^] Z  ##�_`�X�W_ F  ##6aba E ###cdc o  ##�V�V 0 index51_do_translation  d o  ##"�U�U 0 thetype theTypeb > #&#2efe n  #&#0ghg 4  #)#0�Ti
�T 
cobji m  #,#/�S�S 3h o  #&#)�R�R 00 propertiestocolumnsref propertiesToColumnsReff m  #0#1�Q�Q  ` Q  #9#�jklj k  #<#�mm non r  #<#Rpqp n  #<#Nrsr 4  #?#N�Pt
�P 
cobjt l #B#Mu�O�Nu n  #B#Mvwv 4  #E#L�Mx
�M 
cobjx m  #H#K�L�L 3w o  #B#E�K�K 00 propertiestocolumnsref propertiesToColumnsRef�O  �N  s o  #<#?�J�J 0 therecordref theRecordRefq o      �I�I 0 theitem theItemo y�Hy Z  #S#�z{|�Gz = #S#_}~} o  #S#V�F�F 0 theitem theItem~ n  #V#^� 4  #Y#^�E�
�E 
cobj� m  #\#]�D�D � o  #V#Y�C�C 0 constants51_do_translation  { r  #b#k��� m  #b#c�B
�B boovtrue� n      ��� 1  #f#j�A
�A 
qDoT� o  #c#f�@�@ 0 newcue newCue| ��� = #n#z��� o  #n#q�?�? 0 theitem theItem� n  #q#y��� 4  #t#y�>�
�> 
cobj� m  #w#x�=�= � o  #q#t�<�< 0 constants51_do_translation  � ��;� r  #}#���� m  #}#~�:
�: boovfals� n      ��� 1  #�#��9
�9 
qDoT� o  #~#��8�8 0 newcue newCue�;  �G  �H  k R      �7�6�5
�7 .ascrerr ****      � ****�6  �5  l r  #�#���� m  #�#��4
�4 boovtrue� o      �3�3 0 ohdear ohDear�X  �W  ^ ��� l #�#��2�1�0�2  �1  �0  � ��� Z  #�$���/�.� F  #�#���� E #�#���� o  #�#��-�- 0 index52_do_rotation  � o  #�#��,�, 0 thetype theType� > #�#���� n  #�#���� 4  #�#��+�
�+ 
cobj� m  #�#��*�* 4� o  #�#��)�) 00 propertiestocolumnsref propertiesToColumnsRef� m  #�#��(�(  � Q  #�$���� k  #�$
�� ��� r  #�#���� n  #�#���� 4  #�#��'�
�' 
cobj� l #�#���&�%� n  #�#���� 4  #�#��$�
�$ 
cobj� m  #�#��#�# 4� o  #�#��"�" 00 propertiestocolumnsref propertiesToColumnsRef�&  �%  � o  #�#��!�! 0 therecordref theRecordRef� o      � �  0 theitem theItem� ��� Z  #�$
����� = #�#���� o  #�#��� 0 theitem theItem� n  #�#���� 4  #�#���
� 
cobj� m  #�#��� � o  #�#��� 0 constants52_do_rotation  � r  #�#���� m  #�#��
� boovtrue� n      ��� 1  #�#��
� 
qDoR� o  #�#��� 0 newcue newCue� ��� = #�#���� o  #�#��� 0 theitem theItem� n  #�#���� 4  #�#���
� 
cobj� m  #�#��� � o  #�#��� 0 constants52_do_rotation  � ��� r  #�$��� m  #�#��
� boovfals� n      ��� 1  $$�
� 
qDoR� o  #�$�� 0 newcue newCue�  �  �  � R      ���
� .ascrerr ****      � ****�  �  � r  $$��� m  $$�
� boovtrue� o      �
�
 0 ohdear ohDear�/  �.  � ��� l $$�	���	  �  �  � ��� Z  $$������ F  $$6��� E $$#��� o  $$�� 0 index53_do_scale  � o  $$"�� 0 thetype theType� > $&$2��� n  $&$0��� 4  $)$0��
� 
cobj� m  $,$/�� 5� o  $&$)� �  00 propertiestocolumnsref propertiesToColumnsRef� m  $0$1����  � Q  $9$����� k  $<$��� ��� r  $<$R��� n  $<$N��� 4  $?$N���
�� 
cobj� l $B$M������ n  $B$M��� 4  $E$L���
�� 
cobj� m  $H$K���� 5� o  $B$E���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  $<$?���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  $S$������� = $S$_��� o  $S$V���� 0 theitem theItem� n  $V$^��� 4  $Y$^���
�� 
cobj� m  $\$]���� � o  $V$Y���� 0 constants53_do_scale  � r  $b$k��� m  $b$c��
�� boovtrue� n      ��� 1  $f$j��
�� 
qDoS� o  $c$f���� 0 newcue newCue� ��� = $n$z��� o  $n$q���� 0 theitem theItem� n  $q$y��� 4  $t$y���
�� 
cobj� m  $w$x���� � o  $q$t���� 0 constants53_do_scale  � ���� r  $}$�   m  $}$~��
�� boovfals n       1  $�$���
�� 
qDoS o  $~$����� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  $�$� m  $�$���
�� boovtrue o      ���� 0 ohdear ohDear�  �  �  l $�$���������  ��  ��   	 Z  $�%�
����
 F  $�$� E $�$� o  $�$����� 0 index54_command   o  $�$����� 0 thetype theType > $�$� n  $�$� 4  $�$���
�� 
cobj m  $�$����� 6 o  $�$����� 00 propertiestocolumnsref propertiesToColumnsRef m  $�$�����   l $�%� Q  $�%� k  $�%�  r  $�$� n  $�$� !  4  $�$���"
�� 
cobj" l $�$�#����# n  $�$�$%$ 4  $�$���&
�� 
cobj& m  $�$����� 6% o  $�$����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  ! o  $�$����� 0 therecordref theRecordRef o      ���� 0 theitem theItem '��' Z  $�%�()*��( = $�$�+,+ o  $�$����� 0 theitem theItem, n  $�$�-.- 4  $�$���/
�� 
cobj/ m  $�$����� . o  $�$����� 0 constants54_command  ) r  $�$�010 m  $�$���
�� MICONtOn1 n      232 1  $�$���
�� 
qCOm3 o  $�$����� 0 newcue newCue* 454 = $�$�676 o  $�$����� 0 theitem theItem7 n  $�$�898 4  $�$���:
�� 
cobj: m  $�$����� 9 o  $�$����� 0 constants54_command  5 ;<; r  $�%
=>= m  $�%��
�� MICONtOf> n      ?@? 1  %%	��
�� 
qCOm@ o  %%���� 0 newcue newCue< ABA = %%CDC o  %%���� 0 theitem theItemD n  %%EFE 4  %%��G
�� 
cobjG m  %%���� F o  %%���� 0 constants54_command  B HIH r  %%'JKJ m  %%��
�� MICOPrChK n      LML 1  %"%&��
�� 
qCOmM o  %%"���� 0 newcue newCueI NON = %*%8PQP o  %*%-���� 0 theitem theItemQ n  %-%7RSR 4  %0%7��T
�� 
cobjT m  %3%6���� S o  %-%0���� 0 constants54_command  O UVU r  %;%FWXW m  %;%>��
�� MICOCtChX n      YZY 1  %A%E��
�� 
qCOmZ o  %>%A���� 0 newcue newCueV [\[ = %I%W]^] o  %I%L���� 0 theitem theItem^ n  %L%V_`_ 4  %O%V��a
�� 
cobja m  %R%U���� ` o  %L%O���� 0 constants54_command  \ bcb r  %Z%eded m  %Z%]��
�� MICOKyPre n      fgf 1  %`%d��
�� 
qCOmg o  %]%`���� 0 newcue newCuec hih = %h%vjkj o  %h%k���� 0 theitem theItemk n  %k%ulml 4  %n%u��n
�� 
cobjn m  %q%t���� m o  %k%n���� 0 constants54_command  i opo r  %y%�qrq m  %y%|��
�� MICOChPrr n      sts 1  %%���
�� 
qCOmt o  %|%���� 0 newcue newCuep uvu = %�%�wxw o  %�%����� 0 theitem theItemx n  %�%�yzy 4  %�%���{
�� 
cobj{ m  %�%����� z o  %�%����� 0 constants54_command  v |��| r  %�%�}~} m  %�%���
�� MICOPiBe~ n      � 1  %�%���
�� 
qCOm� o  %�%����� 0 newcue newCue��  ��  ��   R      ������
�� .ascrerr ****      � ****��  ��   r  %�%���� m  %�%���
�� boovtrue� o      ���� 0 ohdear ohDear   index13_midi_command    ��� *   i n d e x 1 3 _ m i d i _ c o m m a n d��  ��  	 ��� l %�%���������  ��  ��  � ��� Z  %�&������� F  %�%���� E %�%���� o  %�%��� 0 index55_channel  � o  %�%��� 0 thetype theType� > %�%���� n  %�%���� 4  %�%���
� 
cobj� m  %�%��� 7� o  %�%��� 00 propertiestocolumnsref propertiesToColumnsRef� m  %�%���  � Q  %�&���� k  %�&�� ��� r  %�%���� n  %�%���� 4  %�%���
� 
cobj� l %�%����� n  %�%���� 4  %�%���
� 
cobj� m  %�%��� 7� o  %�%��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  %�%��� 0 therecordref theRecordRef� o      �� 0 theitem theItem� ��� Z  %�&����� > %�%���� o  %�%��~�~ 0 theitem theItem� m  %�%��� ���  � r  %�&	��� c  %�&��� o  %�%��}�} 0 theitem theItem� m  %�& �|
�| 
long� n      ��� 1  &&�{
�{ 
qCHa� o  &&�z�z 0 newcue newCue�  �  �  � R      �y�x�w
�y .ascrerr ****      � ****�x  �w  � r  &&��� m  &&�v
�v boovtrue� o      �u�u 0 ohdear ohDear��  ��  � ��� l &&�t�s�r�t  �s  �r  � ��� Z  &&����q�p� F  &&9��� E &&&��� o  &&"�o�o 0 index56_byte_one  � o  &"&%�n�n 0 thetype theType� > &)&5��� n  &)&3��� 4  &,&3�m�
�m 
cobj� m  &/&2�l�l 8� o  &)&,�k�k 00 propertiestocolumnsref propertiesToColumnsRef� m  &3&4�j�j  � Q  &<&����� k  &?&s�� ��� r  &?&U��� n  &?&Q��� 4  &B&Q�i�
�i 
cobj� l &E&P��h�g� n  &E&P��� 4  &H&O�f�
�f 
cobj� m  &K&N�e�e 8� o  &E&H�d�d 00 propertiestocolumnsref propertiesToColumnsRef�h  �g  � o  &?&B�c�c 0 therecordref theRecordRef� o      �b�b 0 theitem theItem� ��a� Z  &V&s���`�_� > &V&]��� o  &V&Y�^�^ 0 theitem theItem� m  &Y&\�� ���  � r  &`&o��� c  &`&g��� o  &`&c�]�] 0 theitem theItem� m  &c&f�\
�\ 
long� n      ��� 1  &j&n�[
�[ 
qBy1� o  &g&j�Z�Z 0 newcue newCue�`  �_  �a  � R      �Y�X�W
�Y .ascrerr ****      � ****�X  �W  � r  &{&���� m  &{&|�V
�V boovtrue� o      �U�U 0 ohdear ohDear�q  �p  � ��� l &�&��T�S�R�T  �S  �R  � ��� Z  &�&����Q�P� F  &�&���� E &�&���� o  &�&��O�O 0 index57_byte_two  � o  &�&��N�N 0 thetype theType� > &�&���� n  &�&���� 4  &�&��M�
�M 
cobj� m  &�&��L�L 9� o  &�&��K�K 00 propertiestocolumnsref propertiesToColumnsRef� m  &�&��J�J  � Q  &�&����� k  &�&��� ��� r  &�&���� n  &�&���� 4  &�&��I�
�I 
cobj� l &�&���H�G� n  &�&���� 4  &�&��F�
�F 
cobj� m  &�&��E�E 9� o  &�&��D�D 00 propertiestocolumnsref propertiesToColumnsRef�H  �G  � o  &�&��C�C 0 therecordref theRecordRef� o      �B�B 0 theitem theItem� ��A� Z  &�&����@�?� > &�&�� � o  &�&��>�> 0 theitem theItem  m  &�&� �  � r  &�&� c  &�&� o  &�&��=�= 0 theitem theItem m  &�&��<
�< 
long n       1  &�&��;
�; 
qBy2 o  &�&��:�: 0 newcue newCue�@  �?  �A  � R      �9�8�7
�9 .ascrerr ****      � ****�8  �7  � r  &�&�	
	 m  &�&��6
�6 boovtrue
 o      �5�5 0 ohdear ohDear�Q  �P  �  l &�&��4�3�2�4  �3  �2    Z  &�'T�1�0 F  &�' E &�&� o  &�&��/�/ 0 index58_byte_combo   o  &�&��.�. 0 thetype theType > &�' n  &�&� 4  &�&��-
�- 
cobj m  &�&��,�, : o  &�&��+�+ 00 propertiestocolumnsref propertiesToColumnsRef m  &�' �*�*   Q  ''P k  ''C  r  ''! !  n  ''"#" 4  ''�)$
�) 
cobj$ l ''%�(�'% n  ''&'& 4  ''�&(
�& 
cobj( m  ''�%�% :' o  ''�$�$ 00 propertiestocolumnsref propertiesToColumnsRef�(  �'  # o  ''�#�# 0 therecordref theRecordRef! o      �"�" 0 theitem theItem )�!) Z  '"'C*+� �* > '"'),-, o  '"'%�� 0 theitem theItem- m  '%'(.. �//  + l ','?0120 r  ','?343 l ','75��5 [  ','7676 l ','38��8 c  ','39:9 o  ','/�� 0 theitem theItem: m  '/'2�
� 
long�  �  7 m  '3'6��  �  �  4 n      ;<; 1  ':'>�
� 
qBy3< o  '7':�� 0 newcue newCue1 . ( Pitch bend of 0 needs to be set as 8192   2 �== P   P i t c h   b e n d   o f   0   n e e d s   t o   b e   s e t   a s   8 1 9 2�   �  �!   R      ���
� .ascrerr ****      � ****�  �   r  'K'P>?> m  'K'L�
� boovtrue? o      �� 0 ohdear ohDear�1  �0   @A@ l 'U'U����  �  �  A BCB Z  'U'�DE��D F  'U'oFGF E 'U'\HIH o  'U'X�
�
 0 index59_end_value  I o  'X'[�	�	 0 thetype theTypeG > '_'kJKJ n  '_'iLML 4  'b'i�N
� 
cobjN m  'e'h�� ;M o  '_'b�� 00 propertiestocolumnsref propertiesToColumnsRefK m  'i'j��  E Q  'r'�OPQO k  'u'�RR STS r  'u'�UVU n  'u'�WXW 4  'x'��Y
� 
cobjY l '{'�Z��Z n  '{'�[\[ 4  '~'��]
� 
cobj] m  '�'�� �  ;\ o  '{'~���� 00 propertiestocolumnsref propertiesToColumnsRef�  �  X o  'u'x���� 0 therecordref theRecordRefV o      ���� 0 theitem theItemT ^��^ Z  '�'�_`����_ > '�'�aba o  '�'����� 0 theitem theItemb m  '�'�cc �dd  ` Z  '�'�ef��ge > '�'�hih n  '�'�jkj 1  '�'���
�� 
qCOmk o  '�'����� 0 newcue newCuei m  '�'���
�� MICOPiBef r  '�'�lml c  '�'�non o  '�'����� 0 theitem theItemo m  '�'���
�� 
longm n      pqp 1  '�'���
�� 
qEVAq o  '�'����� 0 newcue newCue��  g l '�'�rstr r  '�'�uvu l '�'�w����w [  '�'�xyx l '�'�z����z c  '�'�{|{ o  '�'����� 0 theitem theItem| m  '�'���
�� 
long��  ��  y m  '�'�����  ��  ��  v n      }~} 1  '�'���
�� 
qEVA~ o  '�'����� 0 newcue newCues 9 3 This origin shift won't work if command isn't set!   t � f   T h i s   o r i g i n   s h i f t   w o n ' t   w o r k   i f   c o m m a n d   i s n ' t   s e t !��  ��  ��  P R      ������
�� .ascrerr ****      � ****��  ��  Q r  '�'���� m  '�'���
�� boovtrue� o      ���� 0 ohdear ohDear�  �  C ��� l '�'���������  ��  ��  � ��� Z  '�(b������� F  '�'���� E '�'���� o  '�'����� 0 index60_fade  � o  '�'����� 0 thetype theType� > '�'���� n  '�'���� 4  '�'����
�� 
cobj� m  '�'����� <� o  '�'����� 00 propertiestocolumnsref propertiesToColumnsRef� m  '�'�����  � Q  '�(^���� k  '�(Q�� ��� r  '�(��� n  '�(��� 4  ((���
�� 
cobj� l ((������ n  ((��� 4  ((���
�� 
cobj� m  ((���� <� o  ((���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  '�(���� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  ((Q������ = (("��� o  ((���� 0 theitem theItem� n  ((!��� 4  ((!���
�� 
cobj� m  (( ���� � o  ((���� 0 constants60_fade  � r  (%(0��� m  (%((��
�� YorNYyes� n      ��� 1  (+(/��
�� 
qDoF� o  (((+���� 0 newcue newCue� ��� = (3(?��� o  (3(6���� 0 theitem theItem� n  (6(>��� 4  (9(>���
�� 
cobj� m  (<(=���� � o  (6(9���� 0 constants60_fade  � ���� r  (B(M��� m  (B(E��
�� YorNNnoo� n      ��� 1  (H(L��
�� 
qDoF� o  (E(H�� 0 newcue newCue��  ��  ��  � R      ���
� .ascrerr ****      � ****�  �  � r  (Y(^��� m  (Y(Z�
� boovtrue� o      �� 0 ohdear ohDear��  ��  � ��� l (c(c����  �  �  � ��� Z  (c(������ F  (c(}��� E (c(j��� o  (c(f�� 0 index61_command_format  � o  (f(i�� 0 thetype theType� > (m(y��� n  (m(w��� 4  (p(w��
� 
cobj� m  (s(v�� =� o  (m(p�� 00 propertiestocolumnsref propertiesToColumnsRef� m  (w(x��  � Q  (�(����� k  (�(��� ��� r  (�(���� n  (�(���� 4  (�(���
� 
cobj� l (�(����� n  (�(���� 4  (�(���
� 
cobj� m  (�(��� =� o  (�(��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  (�(��� 0 therecordref theRecordRef� o      �� 0 theitem theItem� ��� Z  (�(������ E (�(���� o  (�(���  0 translation61_command_format  � o  (�(��� 0 theitem theItem� Y  (�(������� Z  (�(������ = (�(���� o  (�(��� 0 theitem theItem� n  (�(���� 4  (�(���
� 
cobj� o  (�(��� 0 j  � o  (�(���  0 translation61_command_format  � k  (�(��� ��� r  (�(���� c  (�(���� n  (�(���� 4  (�(���
� 
cobj� l (�(����� \  (�(���� o  (�(��� 0 j  � m  (�(��� �  �  � o  (�(���  0 translation61_command_format  � m  (�(��
� 
long� n      ��� 1  (�(��
� 
qFor� o  (�(��� 0 newcue newCue� ���  S  (�(��  �  �  � 0 j  � m  (�(��� � I (�(����
� .corecnte****       ****� o  (�(���  0 translation61_command_format  �  � m  (�(��� �  � r  (�(���� m  (�(��
� boovtrue� o      �� 0 ohdear ohDear�  � R      ���
� .ascrerr ****      � ****�  �  � r  (�(���� m  (�(��
� boovtrue� o      �� 0 ohdear ohDear�  �  � � � l (�(�����  �  �     Z  (�)��� F  (�) E (�) o  (�)�� 0 index62_command_number   o  ))�� 0 thetype theType > ))	
	 n  )) 4  ))�~
�~ 
cobj m  ))�}�} > o  ))�|�| 00 propertiestocolumnsref propertiesToColumnsRef
 m  ))�{�{   Q  ))� k  ))�  r  ))4 n  ))0 4  )!)0�z
�z 
cobj l )$)/�y�x n  )$)/ 4  )').�w
�w 
cobj m  )*)-�v�v > o  )$)'�u�u 00 propertiestocolumnsref propertiesToColumnsRef�y  �x   o  ))!�t�t 0 therecordref theRecordRef o      �s�s 0 theitem theItem �r Z  )5)��q  E )5)<!"! o  )5)8�p�p  0 translation62_command_number  " o  )8);�o�o 0 theitem theItem Y  )?)#�n$%&# Z  )O)z'(�m�l' = )O)[)*) o  )O)R�k�k 0 theitem theItem* n  )R)Z+,+ 4  )U)Z�j-
�j 
cobj- o  )X)Y�i�i 0 j  , o  )R)U�h�h  0 translation62_command_number  ( k  )^)v.. /0/ r  )^)t121 c  )^)l343 n  )^)h565 4  )a)h�g7
�g 
cobj7 l )d)g8�f�e8 \  )d)g9:9 o  )d)e�d�d 0 j  : m  )e)f�c�c �f  �e  6 o  )^)a�b�b  0 translation62_command_number  4 m  )h)k�a
�a 
long2 n      ;<; 1  )o)s�`
�` 
qCom< o  )l)o�_�_ 0 newcue newCue0 =�^=  S  )u)v�^  �m  �l  �n 0 j  $ m  )B)C�]�] % I )C)J�\>�[
�\ .corecnte****       ****> o  )C)F�Z�Z  0 translation62_command_number  �[  & m  )J)K�Y�Y �q    r  )�)�?@? m  )�)��X
�X boovtrue@ o      �W�W 0 ohdear ohDear�r   R      �V�U�T
�V .ascrerr ****      � ****�U  �T   r  )�)�ABA m  )�)��S
�S boovtrueB o      �R�R 0 ohdear ohDear�  �   CDC l )�)��Q�P�O�Q  �P  �O  D EFE Z  )�)�GH�N�MG F  )�)�IJI E )�)�KLK o  )�)��L�L 0 index63_q__number  L o  )�)��K�K 0 thetype theTypeJ > )�)�MNM n  )�)�OPO 4  )�)��JQ
�J 
cobjQ m  )�)��I�I ?P o  )�)��H�H 00 propertiestocolumnsref propertiesToColumnsRefN m  )�)��G�G  H Q  )�)�RSTR k  )�)�UU VWV r  )�)�XYX n  )�)�Z[Z 4  )�)��F\
�F 
cobj\ l )�)�]�E�D] n  )�)�^_^ 4  )�)��C`
�C 
cobj` m  )�)��B�B ?_ o  )�)��A�A 00 propertiestocolumnsref propertiesToColumnsRef�E  �D  [ o  )�)��@�@ 0 therecordref theRecordRefY o      �?�? 0 theitem theItemW a�>a Z  )�)�bc�=�<b > )�)�ded o  )�)��;�; 0 theitem theIteme m  )�)�ff �gg  c r  )�)�hih o  )�)��:�: 0 theitem theItemi n      jkj 1  )�)��9
�9 
qmsNk o  )�)��8�8 0 newcue newCue�=  �<  �>  S R      �7�6�5
�7 .ascrerr ****      � ****�6  �5  T r  )�)�lml m  )�)��4
�4 boovtruem o      �3�3 0 ohdear ohDear�N  �M  F non l )�)��2�1�0�2  �1  �0  o pqp Z  )�*\rs�/�.r F  )�*tut E )�*vwv o  )�)��-�- 0 index64_q__list  w o  )�*�,�, 0 thetype theTypeu > **xyx n  **z{z 4  **�+|
�+ 
cobj| m  **�*�* @{ o  **�)�) 00 propertiestocolumnsref propertiesToColumnsRefy m  **�(�(  s Q  **X}~} k  **K�� ��� r  **1��� n  **-��� 4  **-�'�
�' 
cobj� l *!*,��&�%� n  *!*,��� 4  *$*+�$�
�$ 
cobj� m  *'**�#�# @� o  *!*$�"�" 00 propertiestocolumnsref propertiesToColumnsRef�&  �%  � o  **�!�! 0 therecordref theRecordRef� o      � �  0 theitem theItem� ��� Z  *2*K����� > *2*9��� o  *2*5�� 0 theitem theItem� m  *5*8�� ���  � r  *<*G��� o  *<*?�� 0 theitem theItem� n      ��� 1  *B*F�
� 
qmsL� o  *?*B�� 0 newcue newCue�  �  �  ~ R      ���
� .ascrerr ****      � ****�  �   r  *S*X��� m  *S*T�
� boovtrue� o      �� 0 ohdear ohDear�/  �.  q ��� l *]*]����  �  �  � ��� Z  *]*������ F  *]*w��� E *]*d��� o  *]*`�� 0 index65_q__path  � o  *`*c�� 0 thetype theType� > *g*s��� n  *g*q��� 4  *j*q��
� 
cobj� m  *m*p�� A� o  *g*j�
�
 00 propertiestocolumnsref propertiesToColumnsRef� m  *q*r�	�	  � Q  *z*����� k  *}*��� ��� r  *}*���� n  *}*���� 4  *�*���
� 
cobj� l *�*����� n  *�*���� 4  *�*���
� 
cobj� m  *�*��� A� o  *�*��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  *}*��� 0 therecordref theRecordRef� o      �� 0 theitem theItem� �� � Z  *�*�������� > *�*���� o  *�*����� 0 theitem theItem� m  *�*��� ���  � r  *�*���� o  *�*����� 0 theitem theItem� n      ��� 1  *�*���
�� 
qmsP� o  *�*����� 0 newcue newCue��  ��  �   � R      ������
�� .ascrerr ****      � ****��  ��  � r  *�*���� m  *�*���
�� boovtrue� o      ���� 0 ohdear ohDear�  �  � ��� l *�*���������  ��  ��  � ��� Z  *�+$������� F  *�*���� E *�*���� o  *�*����� 0 index66_macro  � o  *�*����� 0 thetype theType� > *�*���� n  *�*���� 4  *�*����
�� 
cobj� m  *�*����� B� o  *�*����� 00 propertiestocolumnsref propertiesToColumnsRef� m  *�*�����  � Q  *�+ ���� k  *�+�� ��� r  *�*���� n  *�*���� 4  *�*����
�� 
cobj� l *�*������� n  *�*���� 4  *�*����
�� 
cobj� m  *�*����� B� o  *�*����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  *�*����� 0 therecordref theRecordRef� o      ���� 0 theitem theItem� ���� Z  *�+������� > *�*���� o  *�*����� 0 theitem theItem� m  *�*��� ���  � r  + +��� c  + +��� o  + +���� 0 theitem theItem� m  ++��
�� 
long� n      ��� 1  +
+��
�� 
qMac� o  ++
���� 0 newcue newCue��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r  ++ ��� m  ++��
�� boovtrue� o      ���� 0 ohdear ohDear��  ��  � ��� l +%+%��������  ��  ��  � ��� Z  +%+�������� F  +%+?��� E +%+,��� o  +%+(���� 0 index67_control_number  � o  +(++���� 0 thetype theType� > +/+;��� n  +/+9��� 4  +2+9���
�� 
cobj� m  +5+8���� C� o  +/+2���� 00 propertiestocolumnsref propertiesToColumnsRef� m  +9+:����  � Q  +B+�   k  +E+y  r  +E+[ n  +E+W	 4  +H+W��

�� 
cobj
 l +K+V���� n  +K+V 4  +N+U��
�� 
cobj m  +Q+T���� C o  +K+N���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  	 o  +E+H���� 0 therecordref theRecordRef o      ���� 0 theitem theItem �� Z  +\+y��� > +\+c o  +\+_�� 0 theitem theItem m  +_+b �   r  +f+u c  +f+m o  +f+i�� 0 theitem theItem m  +i+l�
� 
long n       1  +p+t�
� 
qCNt o  +m+p�� 0 newcue newCue��  �  ��   R      ���
� .ascrerr ****      � ****�  �   r  +�+� m  +�+��
� boovtrue o      �� 0 ohdear ohDear��  ��  �  l +�+�����  �  �    !  Z  +�+�"#��" F  +�+�$%$ E +�+�&'& o  +�+��� 0 index68_control_value  ' o  +�+��� 0 thetype theType% > +�+�()( n  +�+�*+* 4  +�+��,
� 
cobj, m  +�+��� D+ o  +�+��� 00 propertiestocolumnsref propertiesToColumnsRef) m  +�+���  # Q  +�+�-./- k  +�+�00 121 r  +�+�343 n  +�+�565 4  +�+��7
� 
cobj7 l +�+�8��8 n  +�+�9:9 4  +�+��;
� 
cobj; m  +�+��� D: o  +�+��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  6 o  +�+��� 0 therecordref theRecordRef4 o      �� 0 theitem theItem2 <�< Z  +�+�=>��= > +�+�?@? o  +�+��� 0 theitem theItem@ m  +�+�AA �BB  > r  +�+�CDC c  +�+�EFE o  +�+��� 0 theitem theItemF m  +�+��
� 
longD n      GHG 1  +�+��
� 
qCNvH o  +�+��� 0 newcue newCue�  �  �  . R      ���
� .ascrerr ****      � ****�  �  / r  +�+�IJI m  +�+��
� boovtrueJ o      �� 0 ohdear ohDear�  �  ! KLK l +�+�����  �  �  L MNM Z  +�,VOP��O F  +�,QRQ E +�+�STS o  +�+��� 0 index69_hours  T o  +�+��� 0 thetype theTypeR > +�,UVU n  +�,WXW 4  +�,�Y
� 
cobjY m  ,,�� EX o  +�+��� 00 propertiestocolumnsref propertiesToColumnsRefV m  ,,��  P Q  ,,RZ[\Z k  ,,E]] ^_^ r  ,,'`a` n  ,,#bcb 4  ,,#�d
� 
cobjd l ,,"e��e n  ,,"fgf 4  ,,!�h
� 
cobjh m  ,, �� Eg o  ,,�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  c o  ,,�� 0 therecordref theRecordRefa o      �� 0 theitem theItem_ i�i Z  ,(,Ejk��j > ,(,/lml o  ,(,+�~�~ 0 theitem theItemm m  ,+,.nn �oo  k r  ,2,Apqp c  ,2,9rsr o  ,2,5�}�} 0 theitem theItems m  ,5,8�|
�| 
longq n      tut 1  ,<,@�{
�{ 
qHouu o  ,9,<�z�z 0 newcue newCue�  �  �  [ R      �y�x�w
�y .ascrerr ****      � ****�x  �w  \ r  ,M,Rvwv m  ,M,N�v
�v boovtruew o      �u�u 0 ohdear ohDear�  �  N xyx l ,W,W�t�s�r�t  �s  �r  y z{z Z  ,W,�|}�q�p| F  ,W,q~~ E ,W,^��� o  ,W,Z�o�o 0 index70_minutes  � o  ,Z,]�n�n 0 thetype theType > ,a,m��� n  ,a,k��� 4  ,d,k�m�
�m 
cobj� m  ,g,j�l�l F� o  ,a,d�k�k 00 propertiestocolumnsref propertiesToColumnsRef� m  ,k,l�j�j  } Q  ,t,����� k  ,w,��� ��� r  ,w,���� n  ,w,���� 4  ,z,��i�
�i 
cobj� l ,},���h�g� n  ,},���� 4  ,�,��f�
�f 
cobj� m  ,�,��e�e F� o  ,},��d�d 00 propertiestocolumnsref propertiesToColumnsRef�h  �g  � o  ,w,z�c�c 0 therecordref theRecordRef� o      �b�b 0 theitem theItem� ��a� Z  ,�,����`�_� > ,�,���� o  ,�,��^�^ 0 theitem theItem� m  ,�,��� ���  � r  ,�,���� c  ,�,���� o  ,�,��]�] 0 theitem theItem� m  ,�,��\
�\ 
long� n      ��� 1  ,�,��[
�[ 
qMin� o  ,�,��Z�Z 0 newcue newCue�`  �_  �a  � R      �Y�X�W
�Y .ascrerr ****      � ****�X  �W  � r  ,�,���� m  ,�,��V
�V boovtrue� o      �U�U 0 ohdear ohDear�q  �p  { ��� l ,�,��T�S�R�T  �S  �R  � ��� Z  ,�-"���Q�P� F  ,�,���� E ,�,���� o  ,�,��O�O 0 index71_seconds  � o  ,�,��N�N 0 thetype theType� > ,�,���� n  ,�,���� 4  ,�,��M�
�M 
cobj� m  ,�,��L�L G� o  ,�,��K�K 00 propertiestocolumnsref propertiesToColumnsRef� m  ,�,��J�J  � Q  ,�-���� k  ,�-�� ��� r  ,�,���� n  ,�,���� 4  ,�,��I�
�I 
cobj� l ,�,���H�G� n  ,�,���� 4  ,�,��F�
�F 
cobj� m  ,�,��E�E G� o  ,�,��D�D 00 propertiestocolumnsref propertiesToColumnsRef�H  �G  � o  ,�,��C�C 0 therecordref theRecordRef� o      �B�B 0 theitem theItem� ��A� Z  ,�-���@�?� > ,�,���� o  ,�,��>�> 0 theitem theItem� m  ,�,��� ���  � r  ,�-��� c  ,�-��� o  ,�-�=�= 0 theitem theItem� m  --�<
�< 
long� n      ��� 1  --�;
�; 
qSec� o  --�:�: 0 newcue newCue�@  �?  �A  � R      �9�8�7
�9 .ascrerr ****      � ****�8  �7  � r  --��� m  --�6
�6 boovtrue� o      �5�5 0 ohdear ohDear�Q  �P  � ��� l -#-#�4�3�2�4  �3  �2  � ��� Z  -#-����1�0� F  -#-=��� E -#-*��� o  -#-&�/�/ 0 index72_frames  � o  -&-)�.�. 0 thetype theType� > ---9��� n  ---7��� 4  -0-7�-�
�- 
cobj� m  -3-6�,�, H� o  ---0�+�+ 00 propertiestocolumnsref propertiesToColumnsRef� m  -7-8�*�*  � Q  -@-����� k  -C-w�� ��� r  -C-Y��� n  -C-U��� 4  -F-U�)�
�) 
cobj� l -I-T��(�'� n  -I-T��� 4  -L-S�&�
�& 
cobj� m  -O-R�%�% H� o  -I-L�$�$ 00 propertiestocolumnsref propertiesToColumnsRef�(  �'  � o  -C-F�#�# 0 therecordref theRecordRef� o      �"�" 0 theitem theItem� ��!� Z  -Z-w��� �� > -Z-a��� o  -Z-]�� 0 theitem theItem� m  -]-`�� ���  � r  -d-s��� c  -d-k��� o  -d-g�� 0 theitem theItem� m  -g-j�
� 
long� n      ��� 1  -n-r�
� 
qFra� o  -k-n�� 0 newcue newCue�   �  �!  � R      ���
� .ascrerr ****      � ****�  �  � r  --���� m  --��
� boovtrue� o      �� 0 ohdear ohDear�1  �0  � � � l -�-�����  �  �     Z  -�-��� F  -�-� E -�-� o  -�-��� 0 index73_subframes   o  -�-��� 0 thetype theType > -�-�	
	 n  -�-� 4  -�-��
� 
cobj m  -�-��� I o  -�-��� 00 propertiestocolumnsref propertiesToColumnsRef
 m  -�-��
�
   Q  -�-� k  -�-�  r  -�-� n  -�-� 4  -�-��	
�	 
cobj l -�-��� n  -�-� 4  -�-��
� 
cobj m  -�-��� I o  -�-��� 00 propertiestocolumnsref propertiesToColumnsRef�  �   o  -�-��� 0 therecordref theRecordRef o      �� 0 theitem theItem � Z  -�-�� �� > -�-� !  o  -�-����� 0 theitem theItem! m  -�-�"" �##   r  -�-�$%$ c  -�-�&'& o  -�-����� 0 theitem theItem' m  -�-���
�� 
long% n      ()( 1  -�-���
�� 
qSFr) o  -�-����� 0 newcue newCue�   ��  �   R      ������
�� .ascrerr ****      � ****��  ��   r  -�-�*+* m  -�-���
�� boovtrue+ o      ���� 0 ohdear ohDear�  �   ,-, l -�-���������  ��  ��  - ./. Z  -�.n01����0 F  -�.	232 E -�-�454 o  -�-����� 0 index74_send_time_with_set  5 o  -�-����� 0 thetype theType3 > -�.676 n  -�.898 4  -�.��:
�� 
cobj: m  -�.���� J9 o  -�-����� 00 propertiestocolumnsref propertiesToColumnsRef7 m  ..����  1 Q  ..j;<=; k  ..]>> ?@? r  ..%ABA n  ..!CDC 4  ..!��E
�� 
cobjE l .. F����F n  .. GHG 4  ..��I
�� 
cobjI m  ..���� JH o  ..���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  D o  ..���� 0 therecordref theRecordRefB o      ���� 0 theitem theItem@ J��J Z  .&.]KLM��K = .&.2NON o  .&.)���� 0 theitem theItemO n  .).1PQP 4  .,.1��R
�� 
cobjR m  ./.0���� Q o  .).,���� "0 constants74_send_time_with_set  L r  .5.>STS m  .5.6��
�� boovtrueT n      UVU 1  .9.=��
�� 
qSTWV o  .6.9���� 0 newcue newCueM WXW = .A.MYZY o  .A.D���� 0 theitem theItemZ n  .D.L[\[ 4  .G.L��]
�� 
cobj] m  .J.K���� \ o  .D.G���� "0 constants74_send_time_with_set  X ^��^ r  .P.Y_`_ m  .P.Q��
�� boovfals` n      aba 1  .T.X��
�� 
qSTWb o  .Q.T���� 0 newcue newCue��  ��  ��  < R      ������
�� .ascrerr ****      � ****��  ��  = r  .e.jcdc m  .e.f��
�� boovtrued o      ���� 0 ohdear ohDear��  ��  / efe l .o.o��������  ��  ��  f ghg Z  .o.�ij����i F  .o.�klk E .o.vmnm o  .o.r���� 0 index75_sysex_message  n o  .r.u���� 0 thetype theTypel > .y.�opo n  .y.�qrq 4  .|.���s
�� 
cobjs m  ..����� Kr o  .y.|���� 00 propertiestocolumnsref propertiesToColumnsRefp m  .�.�����  j Q  .�.�tuvt k  .�.�ww xyx r  .�.�z{z n  .�.�|}| 4  .�.���~
�� 
cobj~ l .�.��� n  .�.���� 4  .�.���
� 
cobj� m  .�.��� K� o  .�.��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  } o  .�.��� 0 therecordref theRecordRef{ o      �� 0 theitem theItemy ��� Z  .�.������ > .�.���� o  .�.��� 0 theitem theItem� m  .�.��� ���  � r  .�.���� o  .�.��� 0 theitem theItem� n      ��� 1  .�.��
� 
qSEX� o  .�.��� 0 newcue newCue�  �  �  u R      ���
� .ascrerr ****      � ****�  �  v r  .�.���� m  .�.��
� boovtrue� o      �� 0 ohdear ohDear��  ��  h ��� l  .�.�����  �("
                    if theType is in index76_midi_destination and item 76 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 76 of propertiesToColumnsRef) of theRecordRef
                            if theItem is not "" then
                                set midi destination of newCue to theItem
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
    � ���D 
                                         i f   t h e T y p e   i s   i n   i n d e x 7 6 _ m i d i _ d e s t i n a t i o n   a n d   i t e m   7 6   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   7 6   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   n o t   " "   t h e n 
                                                                 s e t   m i d i   d e s t i n a t i o n   o f   n e w C u e   t o   t h e I t e m 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
  � ��� Z  .�/6����� F  .�.���� E .�.���� o  .�.��� 0 index77_start_time_offset  � o  .�.��� 0 thetype theType� > .�.���� n  .�.���� 4  .�.���
� 
cobj� m  .�.��� M� o  .�.��� 00 propertiestocolumnsref propertiesToColumnsRef� m  .�.���  � Q  .�/2���� k  .�/%�� ��� r  .�/��� n  .�/��� 4  .�/��
� 
cobj� l .�/���� n  .�/��� 4  .�/��
� 
cobj� m  .�/ �� M� o  .�.��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  .�.��� 0 therecordref theRecordRef� o      �� 0 theitem theItem� ��� Z  //%����� > //��� o  //�� 0 theitem theItem� m  //�� ���  � r  //!��� c  //��� o  //�� 0 theitem theItem� m  //�
� 
doub� n      ��� 1  // �
� 
qStA� o  //�� 0 newcue newCue�  �  �  � R      ���
� .ascrerr ****      � ****�  �  � r  /-/2��� m  /-/.�
� boovtrue� o      �� 0 ohdear ohDear�  �  � ��� l  /7/7����  �82
                    if theType is in index78_fire_next_cue_when_loop_ends and item 78 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 78 of propertiesToColumnsRef) of theRecordRef
                            if theItem is item 1 of constants78_fire_next_cue_when_loop_ends then
                                set fire next cue when loop ends of newCue to true
                            else if theItem is item 2 of constants78_fire_next_cue_when_loop_ends then
                                set fire next cue when loop ends of newCue to false
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
 
                    if theType is in index79_stop_target_when_loop_ends and item 79 of propertiesToColumnsRef is not 0 then
                        try
                            set theItem to item (item 79 of propertiesToColumnsRef) of theRecordRef
                            if theItem is item 1 of constants79_stop_target_when_loop_ends then
                                set stop target when loop ends of newCue to true
                            else if theItem is item 2 of constants79_stop_target_when_loop_ends then
                                set stop target when loop ends of newCue to false
                            end if
                        on error
                            set ohDear to true
                        end try
                    end if
    � ���d 
                                         i f   t h e T y p e   i s   i n   i n d e x 7 8 _ f i r e _ n e x t _ c u e _ w h e n _ l o o p _ e n d s   a n d   i t e m   7 8   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   7 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   i t e m   1   o f   c o n s t a n t s 7 8 _ f i r e _ n e x t _ c u e _ w h e n _ l o o p _ e n d s   t h e n 
                                                                 s e t   f i r e   n e x t   c u e   w h e n   l o o p   e n d s   o f   n e w C u e   t o   t r u e 
                                                         e l s e   i f   t h e I t e m   i s   i t e m   2   o f   c o n s t a n t s 7 8 _ f i r e _ n e x t _ c u e _ w h e n _ l o o p _ e n d s   t h e n 
                                                                 s e t   f i r e   n e x t   c u e   w h e n   l o o p   e n d s   o f   n e w C u e   t o   f a l s e 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
   
                                         i f   t h e T y p e   i s   i n   i n d e x 7 9 _ s t o p _ t a r g e t _ w h e n _ l o o p _ e n d s   a n d   i t e m   7 9   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                                 t r y 
                                                         s e t   t h e I t e m   t o   i t e m   ( i t e m   7 9   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e R e c o r d R e f 
                                                         i f   t h e I t e m   i s   i t e m   1   o f   c o n s t a n t s 7 9 _ s t o p _ t a r g e t _ w h e n _ l o o p _ e n d s   t h e n 
                                                                 s e t   s t o p   t a r g e t   w h e n   l o o p   e n d s   o f   n e w C u e   t o   t r u e 
                                                         e l s e   i f   t h e I t e m   i s   i t e m   2   o f   c o n s t a n t s 7 9 _ s t o p _ t a r g e t _ w h e n _ l o o p _ e n d s   t h e n 
                                                                 s e t   s t o p   t a r g e t   w h e n   l o o p   e n d s   o f   n e w C u e   t o   f a l s e 
                                                         e n d   i f 
                                                 o n   e r r o r 
                                                         s e t   o h D e a r   t o   t r u e 
                                                 e n d   t r y 
                                         e n d   i f 
  � ��� Z  /7/������ F  /7/Q��� E /7/>��� o  /7/:�� 0 index80_load_time  � o  /:/=�� 0 thetype theType� > /A/M��� n  /A/K��� 4  /D/K��
� 
cobj� m  /G/J�� P� o  /A/D�� 00 propertiestocolumnsref propertiesToColumnsRef� m  /K/L��  � Q  /T/����� k  /W/��� ��� r  /W/m��� n  /W/i��� 4  /Z/i��
� 
cobj� l /]/h���� n  /]/h��� 4  /`/g��
� 
cobj� m  /c/f�� P� o  /]/`�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  /W/Z�� 0 therecordref theRecordRef� o      �~�~ 0 theitem theItem� ��}� Z  /n/����|�{� > /n/u��� o  /n/q�z�z 0 theitem theItem� m  /q/t�� ���  � r  /x/���� c  /x/��� o  /x/{�y�y 0 theitem theItem� m  /{/~�x
�x 
doub� n      ��� 1  /�/��w
�w 
qLTi� o  //��v�v 0 newcue newCue�|  �{  �}  � R      �u�t�s
�u .ascrerr ****      � ****�t  �s  � r  /�/���� m  /�/��r
�r boovtrue� o      �q�q 0 ohdear ohDear�  �  � ��� l /�/��p�o�n�p  �o  �n  � ��� Z  /�/����m�l� F  /�/���� E /�/���� o  /�/��k�k 0 index81_assigned_number  � o  /�/��j�j 0 thetype theType� > /�/���� n  /�/���� 4  /�/��i�
�i 
cobj� m  /�/��h�h Q� o  /�/��g�g 00 propertiestocolumnsref propertiesToColumnsRef� m  /�/��f�f  � Q  /�/�� � k  /�/�  r  /�/� n  /�/� 4  /�/��e	
�e 
cobj	 l /�/�
�d�c
 n  /�/� 4  /�/��b
�b 
cobj m  /�/��a�a Q o  /�/��`�` 00 propertiestocolumnsref propertiesToColumnsRef�d  �c   o  /�/��_�_ 0 therecordref theRecordRef o      �^�^ 0 theitem theItem �] Z  /�/��\�[ > /�/� o  /�/��Z�Z 0 theitem theItem m  /�/� �   r  /�/� o  /�/��Y�Y 0 theitem theItem n       1  /�/��X
�X 
qASN o  /�/��W�W 0 newcue newCue�\  �[  �]    R      �V�U�T
�V .ascrerr ****      � ****�U  �T   r  /�/� m  /�/��S
�S boovtrue o      �R�R 0 ohdear ohDear�m  �l  �  l /�/��Q�P�O�Q  �P  �O    Z  /�0e �N�M > /�0!"! n  /�0	#$# 4  00	�L%
�L 
cobj% m  00�K�K R$ o  /�0�J�J 00 propertiestocolumnsref propertiesToColumnsRef" m  0	0
�I�I    l 00a&'(& Q  00a)*+) k  00T,, -.- r  00'/0/ n  00#121 4  00#�H3
�H 
cobj3 l 00"4�G�F4 n  00"565 4  00!�E7
�E 
cobj7 m  00 �D�D R6 o  00�C�C 00 propertiestocolumnsref propertiesToColumnsRef�G  �F  2 o  00�B�B 0 therecordref theRecordRef0 o      �A�A 0 theitem theItem. 8�@8 Z  0(0T9:�?�>9 > 0(0/;<; o  0(0+�=�= 0 theitem theItem< m  0+0.== �>>  : k  020P?? @A@ l 020GBCDB s  020GEFE n  020BGHG 4  050B�<I
�< 
cobjI l 080AJ�;�:J n  080AKLK 4  0;0@�9M
�9 
cobjM m  0>0?�8�8 L o  080;�7�7 00 propertiestocolumnsref propertiesToColumnsRef�;  �:  H o  0205�6�6 0 therecordref theRecordRefF n      NON  ;  0E0FO o  0B0E�5�5 0 
cuestomove 
cuesToMoveC   This cue's q number   D �PP (   T h i s   c u e ' s   q   n u m b e rA Q�4Q l 0H0PRSTR s  0H0PUVU o  0H0K�3�3 0 theitem theItemV n      WXW  ;  0N0OX o  0K0N�2�2 0 
cuestomove 
cuesToMoveS   The destination group   T �YY ,   T h e   d e s t i n a t i o n   g r o u p�4  �?  �>  �@  * R      �1�0�/
�1 .ascrerr ****      � ****�0  �/  + r  0\0aZ[Z m  0\0]�.
�. boovtrue[ o      �-�- 0 ohdear ohDear' ( " Make a list of cues to move later   ( �\\ D   M a k e   a   l i s t   o f   c u e s   t o   m o v e   l a t e r�N  �M   ]^] l 0f0f�,�+�*�,  �+  �*  ^ _`_ l 0f0f�)ab�)  a   Deal with levels   b �cc "   D e a l   w i t h   l e v e l s` ded l 0f0f�(�'�&�(  �'  �&  e fgf Z  0f1*hi�%�$h E 0f0mjkj o  0f0i�#�#  0 index_setlevel index_setLevelk o  0i0l�"�" 0 thetype theTypei k  0p1&ll mnm X  0p1o�!po k  0�1qq rsr r  0�0�tut m  0�0�vv �ww  "u n     xyx 1  0�0�� 
�  
txdly 1  0�0��
� 
ascrs z{z r  0�0�|}| n  0�0�~~ 4  0�0���
� 
cwor� m  0�0���  n  0�0���� 4  0�0���
� 
cobj� o  0�0��� "0 eachlevelcolumn eachLevelColumn� o  0�0��� 0 	headerrow 	headerRow} o      �� 0 excelcleanup excelCleanup{ ��� l 0�0�����  � B < Deal with Excel formatting: 0,0 becomes "0,0" when exported   � ��� x   D e a l   w i t h   E x c e l   f o r m a t t i n g :   0 , 0   b e c o m e s   " 0 , 0 "   w h e n   e x p o r t e d� ��� r  0�0���� m  0�0��� ���  ,� n     ��� 1  0�0��
� 
txdl� 1  0�0��
� 
ascr� ��� Q  0�1���� Z  0�1����� > 0�0���� n  0�0���� 4  0�0���
� 
cobj� o  0�0��� "0 eachlevelcolumn eachLevelColumn� o  0�0��� 0 therecordref theRecordRef� m  0�0��� ���  � k  0�1�� ��� r  0�0���� c  0�0���� n  0�0���� 4  0�0���
� 
citm� m  0�0��� � o  0�0��� 0 excelcleanup excelCleanup� m  0�0��
� 
long� o      �� 0 therow theRow� ��� r  0�0���� c  0�0���� n  0�0���� 4  0�0��
�
�
 
citm� m  0�0��	�	 � o  0�0��� 0 excelcleanup excelCleanup� m  0�0��
� 
long� o      �� 0 	thecolumn 	theColumn� ��� r  0�0���� c  0�0���� n  0�0���� 4  0�0���
� 
cobj� o  0�0��� "0 eachlevelcolumn eachLevelColumn� o  0�0��� 0 therecordref theRecordRef� m  0�0��
� 
doub� o      �� 0 thelevel theLevel� �� � I 0�1����
�� .QLablevsnull���     aCue� o  0�0����� 0 newcue newCue� ����
�� 
levR� o  0�0����� 0 therow theRow� ����
�� 
levC� o  0�0����� 0 	thecolumn 	theColumn� �����
�� 
levD� o  0�1���� 0 thelevel theLevel��  �   �  �  � R      ������
�� .ascrerr ****      � ****��  ��  � r  11��� m  11��
�� boovtrue� o      ���� 0 ohdear ohDear�  �! "0 eachlevelcolumn eachLevelColumnp o  0s0v���� 0 levelcolumns levelColumnsn ���� r  11&��� 1  11"��
�� 
tab � n     ��� 1  1#1%��
�� 
txdl� 1  1"1#��
�� 
ascr��  �%  �$  g ��� l 1+1+��������  ��  ��  � ��� l 1+1+������  �   Flag any errors   � ���     F l a g   a n y   e r r o r s� ��� l 1+1+��������  ��  ��  � ��� Z  1+1�������� = 1+10��� o  1+1.���� 0 ohdear ohDear� m  1.1/��
�� boovtrue� k  131��� ��� r  131B��� c  131>��� n  131:��� 1  161:��
�� 
qNam� o  1316���� 0 newcue newCue� m  1:1=��
�� 
TEXT� o      ���� 0 existingname existingName� ��� Z  1C1j������ > 1C1J��� o  1C1F���� 0 existingname existingName� m  1F1I�� ���  � l 1M1\���� r  1M1\��� b  1M1T��� m  1M1P�� ��� 
 ! ! ! !  � o  1P1S���� 0 existingname existingName� n      ��� 1  1W1[��
�� 
qNam� o  1T1W���� 0 newcue newCue� \ V q name returns "" if it's empty; notes returns "missing value"; go figure (53)... ;-)   � ��� �   q   n a m e   r e t u r n s   " "   i f   i t ' s   e m p t y ;   n o t e s   r e t u r n s   " m i s s i n g   v a l u e " ;   g o   f i g u r e   ( 5 3 ) . . .   ; - )��  � r  1_1j��� m  1_1b�� ���  ! ! ! !� n      ��� 1  1e1i��
�� 
qNam� o  1b1e���� 0 newcue newCue� ���� Z  1k1�������� = 1k1r�  � o  1k1n���� &0 annotateeveryline annotateEveryLine   m  1n1q   �    N o� k  1u1�       r  1u1�    c  1u1�  	  n  1u1| 
  
 1  1x1|��
�� 
qNot  o  1u1x���� 0 newcue newCue 	 m  1|1��
�� 
TEXT  o      ���� 0 existingnotes existingNotes   ��  Z  1�1�  ��   > 1�1�    o  1�1����� 0 existingnotes existingNotes  m  1�1�   �    m i s s i n g   v a l u e  r  1�1�    b  1�1�    b  1�1�    b  1�1�    b  1�1�    b  1�1�    b  1�1�   !   b  1�1� " # " b  1�1� $ % $ b  1�1� & ' & o  1�1����� 0 existingnotes existingNotes ' o  1�1���
�� 
ret  % o  1�1���
�� 
ret  # m  1�1� ( ( � ) )  M a d e   f r o m   l i n e   ! o  1�1����� 0 i    m  1�1� * * � + +    o f   t e x t   f i l e   "  l 	1�1� ,���� , o  1�1����� 0 thename theName��  ��    m  1�1� - - � . . 
 " :   |    o  1�1����� 0 niceparagraph niceParagraph  m  1�1� / / � 0 0    |  n       1 2 1 1  1�1���
�� 
qNot 2 o  1�1����� 0 newcue newCue��    r  1�1� 3 4 3 b  1�1� 5 6 5 b  1�1� 7 8 7 b  1�1� 9 : 9 b  1�1� ; < ; b  1�1� = > = b  1�1� ? @ ? m  1�1� A A � B B  M a d e   f r o m   l i n e   @ o  1�1����� 0 i   > m  1�1� C C � D D    o f   t e x t   f i l e   " < o  1�1����� 0 thename theName : m  1�1� E E � F F 
 " :   |   8 o  1�1��� 0 niceparagraph niceParagraph 6 m  1�1� G G � H H    | 4 n       I J I 1  1�1��
� 
qNot J o  1�1��� 0 newcue newCue��  ��  ��  ��  ��  ��  �  K� K l 1�1�����  �  �  �  �  L M L l 1�1�����  �  �   M  N O N l 1�1�� P Q�   P 2 , Countdown timer (and opportunity to escape)    Q � R R X   C o u n t d o w n   t i m e r   ( a n d   o p p o r t u n i t y   t o   e s c a p e ) O  S T S l 1�1�����  �  �   T  U V U Z  1�2� W X�� W F  1�2 Y Z Y = 1�1� [ \ [ `  1�1� ] ^ ] o  1�1��� 0 i   ^ m  1�1��� 2 \ m  1�1���   Z ?  1�1� _ ` _ l 1�1� a�� a \  1�1� b c b o  1�1��� 0 	counttext 	countText c o  1�1��� 0 i  �  �   ` m  1�1���  X k  22� d d  e f e r  22 g h g c  22 i j i l 22 k�� k \  22 l m l l 22 n�� n n  22 o p o 1  2
2�
� 
aSlt p l 22
 q�� q I 22
���
� .misccurdldt    ��� null�  �  �  �  �  �   m o  22�� 0 	starttime 	startTime�  �   j m  22�
� 
long h o      �� 0 	timetaken 	timeTaken f  r s r r  22' t u t n 22# v w v I  22#� x�� 0 makemmss makeMMSS x  y� y o  22�� 0 	timetaken 	timeTaken�  �   w  f  22 u o      �� 0 
timestring 
timeString s  z� z Z  2(2� { |�� { = 2(21 } ~ } n  2(2/  �  1  2+2/�
� 
pisf � m  2(2+ � ��                                                                                      @ alis    `  Macintosh HD               Ѳ(�H+   
��QLab.app                                                        �����\        ����  	                	Downloads     Ѳ�      ���\     
�� 
�� �9  ,Macintosh HD:Users: cmg: Downloads: QLab.app    Q L a b . a p p    M a c i n t o s h   H D  Users/cmg/Downloads/QLab.app  /    
��   ~ m  2/20�
� boovtrue | I 242~� � �
� .sysodlogaskr        TEXT � b  242U � � � l 242Q ����� � c  242Q � � � b  242M � � � b  242I � � � l 242E ����� � c  242E � � � b  242A � � � b  242? � � � b  242; � � � m  2427 � � � � �  T i m e   e l a p s e d :   � o  272:���� 0 
timestring 
timeString � m  2;2> � � � � �    -   � o  2?2@���� 0 i   � m  2A2D��
�� 
TEXT��  ��   � m  2E2H � � � � �    o f   � o  2I2L���� 0 	counttext 	countText � m  2M2P��
�� 
TEXT��  ��   � m  2Q2T � � � � �    l i n e s   d o n e . . . � �� � �
�� 
appr � l 	2X2Y ����� � o  2X2Y���� 0 dialogtitle dialogTitle��  ��   � �� � �
�� 
disp � m  2\2]����  � �� � �
�� 
btns � J  2`2h � �  � � � m  2`2c � � � � �  C a n c e l �  �� � m  2c2f � � � � �  O K�   � �~ � �
�~ 
dflt � m  2k2n � � � � �  O K � �} � �
�} 
cbtn � m  2q2t � � � � �  C a n c e l � �| ��{
�| 
givu � m  2w2x�z�z �{  �  �  �  �  �   V  ��y � l 2�2��x�w�v�x  �w  �v  �y  �   Skip the header row   � � � � (   S k i p   t h e   h e a d e r   r o w�� 0 i  � m  ���u�u � o  ���t�t 0 	counttext 	countText��  �  � � � l 2�2��s�r�q�s  �r  �q   �  � � � l 2�2��p � ��p   �   Move cues into groups    � � � � ,   M o v e   c u e s   i n t o   g r o u p s �  � � � l 2�2��o�n�m�o  �n  �m   �  � � � Y  2�2� ��l � � � � Q  2�2� � ��k � k  2�2� � �  � � � r  2�2� � � � n  2�2� � � � 4  2�2��j �
�j 
cobj � o  2�2��i�i 0 i   � o  2�2��h�h 0 
cuestomove 
cuesToMove � o      �g�g "0 cuetomovenumber cueToMoveNumber �  � � � r  2�2� � � � n  2�2� � � � 4  2�2��f �
�f 
cobj � l 2�2� ��e�d � [  2�2� � � � o  2�2��c�c 0 i   � m  2�2��b�b �e  �d   � o  2�2��a�a 0 
cuestomove 
cuesToMove � o      �`�` &0 destinationnumber destinationNumber �  ��_ � I 2�2��^ � �
�^ .coremovenull���     obj  � n  2�2� � � � 4  2�2��] �
�] 
aCue � o  2�2��\�\ "0 cuetomovenumber cueToMoveNumber � 1  2�2��[
�[ 
qCLI � �Z ��Y
�Z 
insh � n  2�2� � � �  ;  2�2� � 4  2�2��X �
�X 
aCue � o  2�2��W�W &0 destinationnumber destinationNumber�Y  �_   � R      �V�U�T
�V .ascrerr ****      � ****�U  �T  �k  �l 0 i   � m  2�2��S�S  � I 2�2��R ��Q
�R .corecnte****       **** � o  2�2��P�P 0 
cuestomove 
cuesToMove�Q   � m  2�2��O�O  �  ��N � l 2�2��M�L�K�M  �L  �K  �N  8 4 IO�J �
�J 
qDoc � m  MN�I�I 6  � � � l 2�2��H�G�F�H  �G  �F   �  � � � l 2�2��E � ��E   �   All done. Hoopla!    � � � � $   A l l   d o n e .   H o o p l a ! �  � � � l 2�2��D�C�B�D  �C  �B   �  � � � r  2�3  � � � c  2�2� � � � l 2�2� ��A�@ � \  2�2� � � � l 2�2� ��?�> � n  2�2� � � � 1  2�2��=
�= 
aSlt � l 2�2� ��<�; � I 2�2��:�9�8
�: .misccurdldt    ��� null�9  �8  �<  �;  �?  �>   � o  2�2��7�7 0 	starttime 	startTime�A  �@   � m  2�2��6
�6 
long � o      �5�5 0 	timetaken 	timeTaken �  � � � r  33! !!  n 33	!!! I  33	�4!�3�4 0 	makenicet 	makeNiceT! !�2! o  33�1�1 0 	timetaken 	timeTaken�2  �3  !  f  33! o      �0�0 0 
timestring 
timeString � !!! I 33�/�.�-
�/ .miscactvnull��� ��� null�.  �-  ! !!	! I 33A�,!
!
�, .sysodlogaskr        TEXT!
 b  33!!! b  33!!! m  33!! �!! ( D o n e .   
   
 ( T h a t   t o o k  ! o  33�+�+ 0 
timestring 
timeString! m  33!! �!! F . ) 
   
 I   h o p e   i t   a l l   w o r k e d   o u t   O K . . .! �*!!
�* 
appr! o  3"3#�)�) 0 dialogtitle dialogTitle! �(!!
�( 
disp! m  3&3'�'�' ! �&!!
�& 
btns! J  3*3/!! !�%! m  3*3-!! �!!  O K�%  ! �$!!
�$ 
dflt! m  3235! !  �!!!!  O K! �#!"�"
�# 
givu!" m  383;�!�! <�"  !	 !#� !# l 3B3B����  �  �  �    m  !$!$�                                                                                      @ alis    `  Macintosh HD               Ѳ(�H+   
��QLab.app                                                        �����\        ����  	                	Downloads     Ѳ�      ���\     
�� 
�� �9  ,Macintosh HD:Users: cmg: Downloads: QLab.app    Q L a b . a p p    M a c i n t o s h   H D  Users/cmg/Downloads/QLab.app  /    
��   !%!&!% l 3E3E����  �  �  !& !'!(!' r  3E3J!)!*!) o  3E3F�� 0 currenttids currentTIDs!* n     !+!,!+ 1  3G3I�
� 
txdl!, 1  3F3G�
� 
ascr!( !-�!- l 3K3K����  �  �  �  
� R L This overall try makes sure TIDs are reset if any "Cancel" button is pushed   
� �!.!. �   T h i s   o v e r a l l   t r y   m a k e s   s u r e   T I D s   a r e   r e s e t   i f   a n y   " C a n c e l "   b u t t o n   i s   p u s h e d
� R      ��!/
� .ascrerr ****      � ****�  !/ �!0�
� 
errn!0 d      !1!1 m      �� ��  
� r  3T3Y!2!3!2 o  3T3U�� 0 currenttids currentTIDs!3 n     !4!5!4 1  3V3X�
� 
txdl!5 1  3U3V�
� 
ascr�X  �W  
� !6!7!6 l     �
�	��
  �	  �  !7 !8!9!8 l     �!:!;�  !:   Subroutines   !; �!<!<    S u b r o u t i n e s!9 !=!>!= l     ����  �  �  !> !?!@!? i     !A!B!A I      �!C��  0 totheclipboard toTheClipboard!C !D�!D o      � �  0 
texttocopy 
textToCopy�  �  !B k     !E!E !F!G!F r     !H!I!H 1     ��
�� 
tab !I n     !J!K!J 1    ��
�� 
txdl!K 1    ��
�� 
ascr!G !L!M!L I   ��!N��
�� .JonspClpnull���     ****!N c    	!O!P!O o    ���� 0 
texttocopy 
textToCopy!P m    ��
�� 
ctxt��  !M !Q��!Q r    !R!S!R o    ���� 0 currenttids currentTIDs!S n     !T!U!T 1    ��
�� 
txdl!U 1    ��
�� 
ascr��  !@ !V!W!V l     ��������  ��  ��  !W !X!Y!X i    !Z![!Z I      �������� 0 exitstrategy exitStrategy��  ��  ![ k     !\!\ !]!^!] I    ��!_!`
�� .sysodlogaskr        TEXT!_ m     !a!a �!b!b � I ' m   a f r a i d   t h a t   f i l e   t a s t e d   f u n n y   s o   I ' v e   h a d   t o   s p i t   i t   o u t .   P l e a s e   c h e c k   t h e   f i l e   a n d   t r y   a g a i n .   S o r r y .!` ��!c!d
�� 
appr!c l 	  !e����!e o    ���� 0 dialogtitle dialogTitle��  ��  !d ��!f!g
�� 
disp!f m    ����  !g ��!h!i
�� 
btns!h J    	!j!j !k��!k m    !l!l �!m!m  O K��  !i ��!n��
�� 
dflt!n m   
 !o!o �!p!p  O K��  !^ !q��!q r    !r!s!r o    ���� 0 currenttids currentTIDs!s n     !t!u!t 1    ��
�� 
txdl!u 1    ��
�� 
ascr��  !Y !v!w!v l     ��������  ��  ��  !w !x!y!x i    !z!{!z I      ��!|���� &0 makeniceparagraph makeNiceParagraph!| !}��!} o      ���� 0 dirtycolumns dirtyColumns��  ��  !{ k     �!~!~ !!�! r     !�!�!� n    !�!�!� 1    ��
�� 
txdl!� 1     ��
�� 
ascr!� o      ���� 0 temptids tempTIDS!� !�!�!� r    !�!�!� m    !�!� �!�!�  !� n     !�!�!� 1    
��
�� 
txdl!� 1    ��
�� 
ascr!� !�!�!� r    !�!�!� m    !�!� �!�!�  !� o      ���� 0 cleanrow cleanRow!� !�!�!� r    !�!�!� m    !�!� �!�!�  !� o      ���� 0 theseparator theSeparator!� !�!�!� X    �!���!�!� k   $ �!�!� !�!�!� Z   $ �!�!�!�!�!� C   $ '!�!�!� o   $ %���� 0 
eachcolumn 
eachColumn!� m   % &!�!� �!�!�  "!� Z   * Z!�!���!�!� H   * .!�!� D   * -!�!�!� o   * +���� 0 
eachcolumn 
eachColumn!� m   + ,!�!� �!�!�  "!� r   1 >!�!�!� b   1 <!�!�!� b   1 4!�!�!� o   1 2���� 0 cleanrow cleanRow!� o   2 3���� 0 theseparator theSeparator!� l  4 ;!�����!� c   4 ;!�!�!� n   4 9!�!�!� 1   7 9��
�� 
rest!� n   4 7!�!�!� 2  5 7��
�� 
cha !� o   4 5���� 0 
eachcolumn 
eachColumn!� m   9 :��
�� 
TEXT��  ��  !� o      ���� 0 cleanrow cleanRow��  !� r   A Z!�!�!� b   A X!�!�!� b   A D!�!�!� o   A B���� 0 cleanrow cleanRow!� o   B C���� 0 theseparator theSeparator!� l  D W!�����!� c   D W!�!�!� n   D U!�!�!� 7  E U��!�!�
�� 
cha !� m   I K�� !� l  L T!���!� \   L T!�!�!� l  M R!���!� I  M R�!��
� .corecnte****       ****!� o   M N�� 0 
eachcolumn 
eachColumn�  �  �  !� m   R S�� �  �  !� o   D E�� 0 
eachcolumn 
eachColumn!� m   U V�
� 
TEXT��  ��  !� o      �� 0 cleanrow cleanRow!� !�!�!� H   ] a!�!� D   ] `!�!�!� o   ] ^�� 0 
eachcolumn 
eachColumn!� m   ^ _!�!� �!�!�  "!� !��!� r   d k!�!�!� b   d i!�!�!� b   d g!�!�!� o   d e�� 0 cleanrow cleanRow!� o   e f�� 0 theseparator theSeparator!� o   g h�� 0 
eachcolumn 
eachColumn!� o      �� 0 cleanrow cleanRow�  !� r   n �!�!�!� b   n �!�!�!� b   n q!�!�!� o   n o�� 0 cleanrow cleanRow!� o   o p�� 0 theseparator theSeparator!� l  q �!���!� c   q �!�!�!� n   q �!�!�!� 7  r ��!�!�
� 
cha !� m   v x�� !� l  y �!���!� \   y �!�!�!� l  z !���!� I  z �!��
� .corecnte****       ****!� o   z {�� 0 
eachcolumn 
eachColumn�  �  �  !� m    ��� �  �  !� o   q r�� 0 
eachcolumn 
eachColumn!� m   � ��
� 
TEXT�  �  !� o      �� 0 cleanrow cleanRow!� !��!� r   � �!�!�!� m   � �!�!� �!�!�    |  !� o      �� 0 theseparator theSeparator�  �� 0 
eachcolumn 
eachColumn!� o    �� 0 dirtycolumns dirtyColumns!� !�!�!� r   � �!�!�!� o   � ��� 0 temptids tempTIDS!� n     !�!�!� 1   � ��
� 
txdl!� 1   � ��
� 
ascr!� !��!� L   � �!�!� o   � ��� 0 cleanrow cleanRow�  !y !�!�!� l     ����  �  �  !� !�!�!� i    " ""  I      �"�� 0 	makenicet 	makeNiceT" "�" o      �� 0 howlong howLong�  �  " k     �"" """ Z     ""��" =    "	"
"	 o     �� 0 howlong howLong"
 m    ��  " L    "" m    "" �"" $ l e s s   t h a n   a   s e c o n d�  �  " """ r    """ _    """ o    �� 0 howlong howLong" m    ��" o      �� 0 howmanyhours howManyHours" """ Z    2""""" =   """ o    �� 0 howmanyhours howManyHours" m    ��  " r    """ m    "" �""  " o      �� 0 
hourstring 
hourString" " "!"  =   """"#"" o     �� 0 howmanyhours howManyHours"# m     !�� "! "$�"$ r   % ("%"&"% m   % &"'"' �"("(  1   h o u r"& o      �� 0 
hourstring 
hourString�  " r   + 2")"*") b   + 0"+","+ l  + ."-��~"- c   + ."."/". o   + ,�}�} 0 howmanyhours howManyHours"/ m   , -�|
�| 
TEXT�  �~  ", m   . /"0"0 �"1"1    h o u r s"* o      �{�{ 0 
hourstring 
hourString" "2"3"2 r   3 :"4"5"4 _   3 8"6"7"6 l  3 6"8�z�y"8 `   3 6"9":"9 o   3 4�x�x 0 howlong howLong": m   4 5�w�w�z  �y  "7 m   6 7�v�v <"5 o      �u�u  0 howmanyminutes howManyMinutes"3 ";"<"; Z   ; Z"=">"?"@"= =  ; >"A"B"A o   ; <�t�t  0 howmanyminutes howManyMinutes"B m   < =�s�s  "> r   A D"C"D"C m   A B"E"E �"F"F  "D o      �r�r 0 minutestring minuteString"? "G"H"G =  G J"I"J"I o   G H�q�q  0 howmanyminutes howManyMinutes"J m   H I�p�p "H "K�o"K r   M P"L"M"L m   M N"N"N �"O"O  1   m i n u t e"M o      �n�n 0 minutestring minuteString�o  "@ r   S Z"P"Q"P b   S X"R"S"R l  S V"T�m�l"T c   S V"U"V"U o   S T�k�k  0 howmanyminutes howManyMinutes"V m   T U�j
�j 
TEXT�m  �l  "S m   V W"W"W �"X"X    m i n u t e s"Q o      �i�i 0 minutestring minuteString"< "Y"Z"Y r   [ b"["\"[ c   [ `"]"^"] `   [ ^"_"`"_ o   [ \�h�h 0 howlong howLong"` m   \ ]�g�g <"^ m   ^ _�f
�f 
long"\ o      �e�e  0 howmanyseconds howManySeconds"Z "a"b"a Z   c �"c"d"e"f"c =  c f"g"h"g o   c d�d�d  0 howmanyseconds howManySeconds"h m   d e�c�c  "d r   i l"i"j"i m   i j"k"k �"l"l  "j o      �b�b 0 secondstring secondString"e "m"n"m =  o r"o"p"o o   o p�a�a  0 howmanyseconds howManySeconds"p m   p q�`�` "n "q�_"q r   u x"r"s"r m   u v"t"t �"u"u  1   s e c o n d"s o      �^�^ 0 secondstring secondString�_  "f r   { �"v"w"v b   { �"x"y"x l  { ~"z�]�\"z c   { ~"{"|"{ o   { |�[�[  0 howmanyseconds howManySeconds"| m   | }�Z
�Z 
TEXT�]  �\  "y m   ~ "}"} �"~"~    s e c o n d s"w o      �Y�Y 0 secondstring secondString"b ""�" Z   � �"�"��X"�"� >  � �"�"�"� o   � ��W�W 0 
hourstring 
hourString"� m   � �"�"� �"�"�  "� Z   � �"�"�"�"�"� F   � �"�"�"� >  � �"�"�"� o   � ��V�V 0 minutestring minuteString"� m   � �"�"� �"�"�  "� >  � �"�"�"� o   � ��U�U 0 secondstring secondString"� m   � �"�"� �"�"�  "� r   � �"�"�"� m   � �"�"� �"�"�  ,  "� o      �T�T 0 theampersand theAmpersand"� "�"�"� G   � �"�"�"� >  � �"�"�"� o   � ��S�S 0 minutestring minuteString"� m   � �"�"� �"�"�  "� >  � �"�"�"� o   � ��R�R 0 secondstring secondString"� m   � �"�"� �"�"�  "� "��Q"� r   � �"�"�"� m   � �"�"� �"�"� 
   a n d  "� o      �P�P 0 theampersand theAmpersand�Q  "� r   � �"�"�"� m   � �"�"� �"�"�  "� o      �O�O 0 theampersand theAmpersand�X  "� r   � �"�"�"� m   � �"�"� �"�"�  "� o      �N�N 0 theampersand theAmpersand"� "�"�"� Z   � �"�"��M"�"� F   � �"�"�"� >  � �"�"�"� o   � ��L�L 0 minutestring minuteString"� m   � �"�"� �"�"�  "� >  � �"�"�"� o   � ��K�K 0 secondstring secondString"� m   � �"�"� �"�"�  "� r   � �"�"�"� m   � �"�"� �"�"� 
   a n d  "� o      �J�J &0 theotherampersand theOtherAmpersand�M  "� r   � �"�"�"� m   � �"�"� �"�"�  "� o      �I�I &0 theotherampersand theOtherAmpersand"� "��H"� L   � �"�"� b   � �"�"�"� b   � �"�"�"� b   � �"�"�"� b   � �"�"�"� o   � ��G�G 0 
hourstring 
hourString"� o   � ��F�F 0 theampersand theAmpersand"� o   � ��E�E 0 minutestring minuteString"� o   � ��D�D &0 theotherampersand theOtherAmpersand"� o   � ��C�C 0 secondstring secondString�H  !� "�"�"� l     �B�A�@�B  �A  �@  "� "�"�"� i    "�"�"� I      �?"��>�? 0 makemmss makeMMSS"� "��="� o      �<�< 0 howlong howLong�=  �>  "� k     0"�"� "�"�"� r     "�"�"� _     "�"�"� o     �;�; 0 howlong howLong"� m    �:�: <"� o      �9�9  0 howmanyminutes howManyMinutes"� "�"�"� r    "�"�"� l   	"��8�7"� c    	"�"�"� o    �6�6  0 howmanyminutes howManyMinutes"� m    �5
�5 
TEXT�8  �7  "� o      �4�4 0 minutestring minuteString"� "�"�"� r    "�"�"� c    "�"�"� `    "�"�"� o    �3�3 0 howlong howLong"� m    �2�2 <"� m    �1
�1 
long"� o      �0�0  0 howmanyseconds howManySeconds"� "�"�"� Z    )"�"��/"�"� ?    "�"�"� o    �.�.  0 howmanyseconds howManySeconds"� m    �-�- 	"� r    "�"�"� l   "��,�+"� c    "�"�"� o    �*�*  0 howmanyseconds howManySeconds"� m    �)
�) 
TEXT�,  �+  "� o      �(�( 0 secondstring secondString�/  "� r   " )"�"�"� b   " '# ##  m   " ### �##  0# l  # &#�'�&# c   # &### o   # $�%�%  0 howmanyseconds howManySeconds# m   $ %�$
�$ 
TEXT�'  �&  "� o      �#�# 0 secondstring secondString"� #�"# L   * 0## b   * /#	#
#	 b   * -### o   * +�!�! 0 minutestring minuteString# m   + ,## �##  :#
 o   - .� �  0 secondstring secondString�"  "� ### l     ����  �  �  # #�# l      �##�  # ' ! END: Make cues from a text file    # �## B   E N D :   M a k e   c u e s   f r o m   a   t e x t   f i l e  �       �#######�  # �������  0 totheclipboard toTheClipboard� 0 exitstrategy exitStrategy� &0 makeniceparagraph makeNiceParagraph� 0 	makenicet 	makeNiceT� 0 makemmss makeMMSS
� .aevtoappnull  �   � ****# �!B��##��  0 totheclipboard toTheClipboard� �#� #  �� 0 
texttocopy 
textToCopy�  # �� 0 
texttocopy 
textToCopy# ���
�	��
� 
tab 
� 
ascr
�
 
txdl
�	 
ctxt
� .JonspClpnull���     ****� 0 currenttids currentTIDs� ���,FO��&j O���,F# �![��## �� 0 exitstrategy exitStrategy�  �  #  #  !a��� ��!l��!o����������
� 
appr� 0 dialogtitle dialogTitle
�  
disp
�� 
btns
�� 
dflt�� 
�� .sysodlogaskr        TEXT�� 0 currenttids currentTIDs
�� 
ascr
�� 
txdl� ����j��kv��� 	O���,F# ��!{����#!#"���� &0 makeniceparagraph makeNiceParagraph�� ��##�� ##  ���� 0 dirtycolumns dirtyColumns��  #! ������������ 0 dirtycolumns dirtyColumns�� 0 temptids tempTIDS�� 0 cleanrow cleanRow�� 0 theseparator theSeparator�� 0 
eachcolumn 
eachColumn#" ����!�!�!�������!�!�������!�!�
�� 
ascr
�� 
txdl
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
cha 
�� 
rest
�� 
TEXT�� ���,E�O���,FO�E�O�E�O {�[��l kh �� 5�� ��%��-�,�&%E�Y ��%�[�\[Zl\Z�j k2�&%E�Y ,�� ��%�%E�Y ��%�[�\[Zk\Z�j k2�&%E�O�E�[OY��O���,FO�# ��"����#$#%���� 0 	makenicet 	makeNiceT�� ��#&�� #&  ���� 0 howlong howLong��  #$ 	�������������������� 0 howlong howLong�� 0 howmanyhours howManyHours�� 0 
hourstring 
hourString��  0 howmanyminutes howManyMinutes�� 0 minutestring minuteString��  0 howmanyseconds howManySeconds�� 0 secondstring secondString�� 0 theampersand theAmpersand�� &0 theotherampersand theOtherAmpersand#% "��""'��"0��"E"N"W��"k"t"}"�"�"���"�"�"�"�"�"�"�"�"�"���
�� 
TEXT�� <
�� 
long
�� 
bool�� ��j  �Y hO��"E�O�j  �E�Y �k  �E�Y 	��&�%E�O��#�"E�O�j  �E�Y �k  �E�Y 	��&�%E�O��#�&E�O�j  �E�Y �k  �E�Y 	��&�%E�O�� @��	 �a a & 
a E�Y #�a 
 �a a & 
a E�Y a E�Y a E�O�a 	 �a a & 
a E�Y a E�O��%�%�%�%# ��"�����#'#(���� 0 makemmss makeMMSS�� ��#)�� #)  ���� 0 howlong howLong��  #' ������������ 0 howlong howLong��  0 howmanyminutes howManyMinutes�� 0 minutestring minuteString��  0 howmanyseconds howManySeconds�� 0 secondstring secondString#( ��������##�� <
�� 
TEXT
�� 
long�� 	�� 1��"E�O��&E�O��#�&E�O�� 
��&E�Y 	��&%E�O��%�%# ��#*����#+#,�
�� .aevtoappnull  �   � ****#* k    3Y#-#-  8#.#.  D#/#/  M#0#0 �#1#1 �#2#2 �#3#3 �#4#4 �#5#5 ]#6#6 �#7#7 �#8#8 #9#9 #:#: #;#; *#<#< :#=#= F#>#> R#?#? r#@#@ �#A#A �#B#B �#C#C �#D#D �#E#E �#F#F �#G#G �#H#H �#I#I �#J#J #K#K #L#L &#M#M 6#N#N J#O#O ^#P#P r#Q#Q �#R#R �#S#S �#T#T �#U#U �#V#V �#W#W �#X#X �#Y#Y #Z#Z #[#[ #\#\ &#]#] 2#^#^ >#_#_ J#`#` V#a#a b#b#b n#c#c z#d#d �#e#e �#f#f �#g#g �#h#h �#i#i �#j#j �#k#k �#l#l �#m#m �#n#n �#o#o 
#p#p #q#q "#r#r .#s#s :#t#t F#u#u T#v#v q#w#w �#x#x �#y#y �#z#z �#{#{ �#|#| �#}#} �#~#~ �## #�#� #�#� (#�#� 5#�#� B#�#� O#�#� \#�#� i#�#� v#�#� �#�#� �#�#� �#�#� �#�#� �#�#� �#�#� �#�#� �#�#� �#�#� #�#� #�#� /#�#� 	�#�#� 
�#�#� 
�#�#� 
�#�#� 
���  ��  ��  #+ ����� 0 eachitem eachItem� 0 i  � 0 j  � "0 eachlevelcolumn eachLevelColumn#,
 =���� W [ _ c g k o s w { � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �$(,048<@DHLQUY]aeimquy}����������������������������
#'+/37;?B��gkosw{�������������������'�47�C�O�\`dhlo��|������������������������ #�03�@DG�TX[�hlo�|����������������������������#�/�;�G�~S�}_�|k�{w�z��y��x��w��v��u��t��s��r��q��p��o�n�m�l+�k7�jC�iO�h^be�gy}��f���e���d�������c���b���a������`���_�^�]�\#&�[03�Z=@�YJM�XWZ�Wdg�Vqt�U~��T���S���R���Q���P���O���N��������M�L���K
�J�I!$�H7;?CGKOSW[_chlptx|��������������������������������			
						#	'	+	/	3	7	;	?	D	H	L	P	T	X	\	`	d	h	l	p	u	y	}	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	��G�F







 
$
(
,
0
4
8
<
@
E
I
M
Q
U
Y
]
a
e
i
m
q
u
y
~
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
�
��E�D�C
��B�A�@k�?�>�=#'*�<.�;1�:�9�89�7H�6�psvy|������������5��4����3d #&),/25AEHKS]��2#��1��0����/��.�-�,�+����*��)�(�'�&�%�$��#�"�!� ���������gsv��������������'8�FRUX����
���	�����������������#'��� I������X������h��wy{������������	&68:<����v���������������U�����������������������������������������������������L������y����������������E����r������������������������������������������������������J����y�����������������������������4��a�������������������������������~.�}�|�{c�z�y�x�w�v�u�t�sf�r�q��p�o��n�m��l�k�j�iA�h�gn�f��e�d��c�b��a�`"�_�^�]�\��[�Z��Y�X��W�V�U=v�T�S���R�Q�P�O�N�M�L�K���   ( * - / A C E G�J�I�H � � � � � � � ��G�F�E�D�C!!!! #�� 0 dialogtitle dialogTitle
� 
ascr
� 
txdl� 0 currenttids currentTIDs� Q� 20 acceptablecolumnheaders acceptableColumnHeaders� *0 customcolumnheaders customColumnHeaders
� 
kocl
� 
cobj
� .corecnte****       ****
� 
TEXT� ,0 reportingonlycolumns reportingOnlyColumns� 0 levelcolumns levelColumns� � "0 acceptabletypes acceptableTypes� � 0 index5_cue_target  � 0 index6_file_target  � � 0 index8_duration  � 0 index21_mode  � 0 index22_sync_to_timecode  � 0 index23_sync_mode  � 0 index24_smpte_format  �  0 index25_mtc_sync_source_name  � 0 index26_ltc_sync_channel  � � 0 index27_patch  � 0 index28_start_time  � 0 index29_end_time  � 0 index30_loop_start_time  � 0 index31_loop_end_time  � 0 index32_loop_count  � 0 index33_infinite_loop  � 0 index34_guarantee_sync  � 0 index35_integrated_fade  � 0 index36_fade_mode  � !0 index37_stop_target_when_done  � 0 index38_auto_stop  � 0 index39_layer  � 0 index40_full_screen  � !0 index41_preserve_aspect_ratio  � 0 index42_opacity  � 0 index43_translation_x  � 0 index44_translation_y  � 0 index45_rotation  � 0 index46_scale_x  � 0 index47_scale_y  � 0 index48_scale_locked  � 0 index49_custom_rendering  � 0 index50_do_opacity  � 0 index51_do_translation  � 0 index52_do_rotation  � 0 index53_do_scale  � 0 index54_command  � 0 index55_channel  � 0 index56_byte_one  � 0 index57_byte_two  � 0 index58_byte_combo  �~ 0 index59_end_value  �} 0 index60_fade  �| 0 index61_command_format  �{ 0 index62_command_number  �z 0 index63_q__number  �y 0 index64_q__list  �x 0 index65_q__path  �w 0 index66_macro  �v 0 index67_control_number  �u 0 index68_control_value  �t 0 index69_hours  �s 0 index70_minutes  �r 0 index71_seconds  �q 0 index72_frames  �p 0 index73_subframes  �o 0 index74_send_time_with_set  �n 0 index75_sysex_message  �m 0 index76_midi_destination  �l 0 index77_start_time_offset  �k (0 $index78_fire_next_cue_when_loop_ends  �j &0 "index79_stop_target_when_loop_ends  �i 0 index80_load_time  �h 0 index81_assigned_number  �g  0 index_setlevel index_setLevel�f 0 constants10_continue_mode  �e 0 constants11_armed  �d 0 constants12_midi_trigger  �c 0 constants13_midi_command  �b  0 constants16_timecode_trigger  �a "0 constants17_wall_clock_trigger  �` 0 constants21_mode  �_  0 constants22_sync_to_timecode  �^ 0 constants23_sync_mode  �] �\ 0 constants24_smpte_format  �[ 0 constants33_infinite_loop  �Z 0 constants34_guarantee_sync  �Y 0 constants35_integrated_fade  �X 0 constants36_fade_mode  �W %0 !constants37_stop_target_when_done  �V 0 constants38_auto_stop  �U 0 constants40_full_screen  �T %0 !constants41_preserve_aspect_ratio  �S 0 constants48_scale_locked  �R  0 constants49_custom_rendering  �Q 0 constants50_do_opacity  �P 0 constants51_do_translation  �O 0 constants52_do_rotation  �N 0 constants53_do_scale  �M �L 0 constants54_command  �K 0 constants60_fade  �J "0 constants74_send_time_with_set  �I ,0 (constants78_fire_next_cue_when_loop_ends  �H *0 &constants79_stop_target_when_loop_ends  �G p�F  0 translation61_command_format  �E 4�D  0 translation62_command_number  �C *0 propertiestocolumns propertiesToColumns�B &0 annotateeveryline annotateEveryLine�A 0 
cuestomove 
cuesToMove�@ 0 thenavigator theNavigator
�? 
appr
�> 
disp
�= 
btns
�< 
dflt
�; 
cbtn�: 

�9 .sysodlogaskr        TEXT
�8 
bhit�7 "0 finishedreading finishedReading�6 (0 instructionbutton1 instructionButton1�5 �4  0 totheclipboard toTheClipboard�3 (0 instructionbutton2 instructionButton2
�2 
prcs#�  
�1 
pnam�0 0 qlabisrunning qLabIsRunning
�/ 
givu
�. 
qDoc
�- 
qSEL�,  �+  
�* 
prmp
�) 
dflc
�( afdrdesk
�' .earsffdralis        afdr
�& 
lfiv
�% .sysostdfalis    ��� null�$ 0 thefile theFile
�# .rdwrread****        ****�" 0 thetext theText�! 0 exitstrategy exitStrategy
�  
extn� 0 theextension theExtension� 0 thename theName� 0 thefullname theFullName
� 
ctxt
� 
leng
� 
tab 
� 
cpar
� 
citm� 0 	headerrow 	headerRow� 00 propertiestocolumnsref propertiesToColumnsRef� 0 
typecolumn 
typeColumn� 0 setrootpath setRootPath
� afdrcusr
� .sysostflalis    ��� null� 0 
pathfinder 
pathFinder
� 
psxp� 0 
pathprefix 
pathPrefix
� .sysodelanull��� ��� nmbr� 0 	counttext 	countText� d� 0 fudgefactor fudgeFactor�
 F�	 0 theeta theETA� (� 0 	makenicet 	makeNiceT� 0 
timestring 
timeString� "0 spuriousplurals spuriousPlurals� 0 goonthen goOnThen
� .miscactvnull��� ��� null
� .misccurdldt    ��� null
� 
aSlt�  0 	starttime 	startTime�� &0 makeniceparagraph makeNiceParagraph�� 0 niceparagraph niceParagraph
�� 
newT
�� .QLabmakenull���     qDoc
�� 
list�� 0 newcue newCue
�� 
qNam
�� 
qNot�� 0 	therecord 	theRecord�� 0 therecordref theRecordRef�� 0 thetype theType�� 0 ohdear ohDear�� 0 theitem theItem�� 0 existingnotes existingNotes
�� 
ret 
�� 
bool
�� 
aCue�� 0 	targetcue 	targetCue
�� 
qQTr
�� 
file
�� 
qFTr
�� 
doub
�� 
qPre
�� 
qDur�� 	
�� 
qPos
�� ContNoCo
�� 
qCon
�� ContDoCo
�� ContDoFo�� 
�� 
qArm
�� YorNYyes
�� 
qUMT
�� YorNNnoo�� 
�� MICONtOn
�� 
qMSt
�� MICONtOf
�� MICOPrCh
�� MICOCtCh
�� MICOKyPr
�� MICOChPr�� 
�� 
long
�� 
qMB1�� 
�� 
qMB2�� 
�� 
qUTC�� 
�� 
qUWC�� 
�� 
qwcH�� 
�� 
qwcM�� 
�� 
qwcS�� 
�� GRUPqGCL
�� 
qGMo
�� GRUPqGSS
�� GRUPqGHS
�� GRUPqGFA
�� GRUPqGFR�� 
�� 
qSTC�� 
�� MTLTsynM
�� 
qSMo
�� MTLTsynL
�� SMPTtfFP
�� 
qSMP
�� SMPTtiFP
�� SMPTthDR
�� SMPTthND�� 
�� 
qMTN�� 
�� 
qLTC�� 
�� 
qPch�� 
�� 
qSta�� 
�� 
qEnd�� !
�� 
qInf�� #
�� 
qIFa�� $
�� ABREABSO
�� 
qAbs
�� ABRERELA�� %
�� 
qAuS� '
� 
qLay
� 
qFSc� )
� 
qPAs� *
� 
qOpa� +
� 
qTrX� ,
� 
qTrY� -
� 
qRot� .
� 
qScX� /
� 
qScY� 2
� 
qDoO� 3
� 
qDoT
� 
qDoR� 5
� 
qDoS� 6
� 
qCOm
� MICOPiBe� 7
� 
qCHa� 8
� 
qBy1� 9
� 
qBy2�~ :�}  
�| 
qBy3�{ ;
�z 
qEVA�y <
�x 
qDoF�w =
�v 
qFor�u >
�t 
qCom�s ?
�r 
qmsN�q @
�p 
qmsL�o A
�n 
qmsP�m B
�l 
qMac�k C
�j 
qCNt�i D
�h 
qCNv�g E
�f 
qHou
�e 
qMin�d G
�c 
qSec�b H
�a 
qFra�` I
�_ 
qSFr�^ J
�] 
qSTW�\ K
�[ 
qSEX�Z M
�Y 
qStA�X P
�W 
qLTi
�V 
qASN�U R
�T 
cwor�S 0 excelcleanup excelCleanup�R 0 therow theRow�Q 0 	thecolumn 	theColumn�P 0 thelevel theLevel
�O 
levR
�N 
levC
�M 
levD
�L .QLablevsnull���     aCue�K 0 existingname existingName�J 0 	timetaken 	timeTaken�I 0 makemmss makeMMSS
�H 
pisf�G "0 cuetomovenumber cueToMoveNumber�F &0 destinationnumber destinationNumber
�E 
qCLI
�D 
insh
�C .coremovenull���     obj #� �B�A�@
�B 
errn�A���@  �3Z�E�O��,E�O�����������a a a a a a a a a a a a a a a a a  a !a "a #a $a %a &a 'a (a )a *a +a ,a -a .a /a 0a 1a 2a 3a 4a 5a 6a 7a 8a 9a :a ;a <a =a >a ?a @a Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua VvE` WOa XkvE` YO $_ Y[a Za [l \kh  �a ]&_ W6G[OY��Oa ^a _a `mvE` aOjvE` bOa ca da ea fa ga ha ia ja ka la ma na oa pa qa ra sa ta ua va wa xa ya za {vE` |Oa }a ~a a �a �a �a �a �a �a �a �a �a �vE` �Oa �a �lvE` �Oa �a �a �a �a �a �vE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �a �a �a �a �a �a �vE` �Oa �a �lvE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �a �lvE` �Oa �kvE` �Oa �a �lvE` �Oa �a �lvE` �Oa �a �lvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` OakvE`OakvE`OakvE`OakvE`Oa	kvE`
OakvE`OakvE`OakvE`OakvE`OakvE`OakvE`OakvE`OakvE`OakvE`OakvE`OakvE` Oa!kvE`"Oa#kvE`$Oa%kvE`&Oa'kvE`(Oa)kvE`*Oa+kvE`,Oa-a.a/mvE`0Oa1a2a3mvE`4Oa5a6lvE`7Oa8a9lvE`:Oa;a<a=a>a?a@a �vE`AOaBaClvE`DOaEaFlvE`GOaHaIaJaKaLa �vE`MOaNaOlvE`POaQaRlvE`SOaTaUaVaWaXvE`YOaZa[lvE`\Oa]a^lvE`_Oa`aalvE`bOacadlvE`eOafaglvE`hOaiajlvE`kOalamlvE`nOaoaplvE`qOaraslvE`tOauavlvE`wOaxaylvE`zOa{a|lvE`}Oa~alvE`�Oa�a�lvE`�Oa�a�a�a�a�a�a�a�vE`�Oa�a�lvE`�Oa�a�lvE`�Oa�a�lvE`�Oa�a�lvE`�Oa�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a aaaaaaaaa	vE`
Oaaaaaaaaaaaaaaaaaaaaaa a!a"a#a$a%a&a'a(a)a*a+a,a-a.a/a0a1a2a3a4a5a6a7a8a9a:a;a<a=a>a?vE`@OjvE`AOaBE`COjvE`DO*�aEE`FO�h_FaG aHaI�aJkaKaLaMaNmvaOaPaQaRaSTaU,E`FO_FaV {fE`WOoh_We aXE`YO �h_YaZa[a\%a]%a^%a_%a`%aa%ab%ac%ad%ae%af%ag%aI�aJkaKahaiajmvaOakalTaU,E`YO_Yam  )_ Wk+nY _Yao  
eE`WY h[OY�oO_Yap  �aqE`rO �h_rasatau%av%aw%ax%ay%az%a{%a|%a}%a~%a%a�%a�%a�%a�%a�%a�%aI�aJkaKa�a�a�mvaOa�alTaU,E`rO_ra�  )_ Wk+nY _ra�  
eE`WY h[OY�[Y h[OY��Y hOP[OY�;Oa� *a�-a�[a�,\Za�81j \E`�UO_�j  -a�aI�aJjaKa�kvaOa�a�a �aSTOhY hOa� @ *a�k/a�,EW /X��a�aI�aJjaKa�kvaOa�a�a �aSTOhUO*a�a�a�a�j�a�fa ��E`�Oa���,FO _�j�E`�W X��)j+�OhOa� U_�a�,E`�O_�a�  _�a�,E`�Y 1_�a�,E`�O_�[a�\[Zk\Z_�a�,_�a�,k2E`�UO_���,FO _�a�k/a�-E`�W X��)j+�OhO_�a� 1a�a�%aI�aJjaKa�kvaOa�alTO���,FOhY hO Rk_ Wj \kh j_A6GO 6k_�j \kh _�a [�/_ Wa [�/  �_Aa [�/FY h[OY��[OY��O)aA,E`�O -k_�j \kh _�a [�/a� �_ b6GY h[OY��O_�a [k/E`�Oa�aI�aJkaKa�a�lvaOa�alTaU,E`�O_�a�  0*a�a�a�a�j�a�fa ��E`�O_�a�,E`�Y 	a�E`�Oa�j�Oa�aI�aJkaKa�a�lvaOa�alTaU,E`CO_�a�-j \E`�O_�_�j \a�! E`�Oa�a�_� a�_�l$ E`�O_�a� �)_�k+�E`�Oa�E`�O �aSkih �k  a�E`�Y hOa�_�%a ]&a�%_�%a�%�%a ]&_�%a�%aI�aJjaKa�a�lvaOa�aQa�a�ka �TaU,E`�O_�a�  Y h[OY��Y hOa�%4*j�Oa�aI�aJkaKa�kvaOa�a�kaSTO*j�a�,E`�O*a�k/$�_Ca�  X)_�k+�E`�O*a�a�l�O*a�,a�&a [i/E`�Oa�_�a�,FOa�_�%a�%_�%a�%_�a�,FY hO#�l_�kh _�a��/a�-E`�O)_�k+�E`�O $h_�j \_�j \a�a ]&_�6G[OY��O)a�,E`�O _�a [_�/E`�W X��a E`�O_ |_� Q*a�al�O*a�,a�&a [i/E`�Oa_�a�,FOa�%a%_�%a%_�%a%_�a�,FY"b*a�_�l�O*a�,a�&a [i/E`�O_Ca  &a�%a	%_�%a
%_�%a%_�a�,FY hOfE`O_�a [l/j C 3_�a [_�a [l/E/E`O_a __�a�,FY hW X��eE`Y hO_�a [m/j C 3_�a [_�a [m/E/E`O_a __�a�,FY hW X��eE`Y hO_�a [aX/j y i_�a [_�a [aX/E/E`O_a D_�a�,a ]&E`O_a __%_%_%_�a�,FY __�a�,FY hW X��eE`Y hO_ �_�	 _�a [a �/ja& c S_�a [_�a [a �/E/a ]&E`O_a **ak/a�[a�,\Z_81E`O__�a,FY hW X��eE`Y hO_ �_�	 _�a [a �/ja& ^ N_�a [_�a [a �/E/E`O_a )a� *a_�_%/EUO_�_%_�a,FY hW X��eE`Y hO_�a [a�/j K ;_�a [_�a [a�/E/E`O_a _a&_�a,FOPY hW X��eE`Y hO_ �_�	 _�a [al/ja& I 9_�a [_�a [al/E/E`O_a _a&_�a ,FY hW X��eE`Y hO_�a [a!/j I 9_�a [_�a [a!/E/E`O_a" _a&_�a#,FY hW X��eE`Y hO_�a [aS/j � t_�a [_�a [aS/E/E`O__4a [k/  a$_�a%,FY =__4a [l/  a&_�a%,FY  __4a [m/  a'_�a%,FY hW X��eE`Y hO_�a [a(/j c S_�a [_�a [a(/E/E`O__7a [k/  e_�a),FY __7a [l/  f_�a),FY hW X��eE`Y hO_�a [a �/j g W_�a [_�a [a �/E/E`O__:a [k/  a*_�a+,FY  __:a [l/  a,_�a+,FY hW X��eE`Y hO_�a [a-/j � �_�a [_�a [a-/E/E`O__Aa [k/  a._�a/,FY �__Aa [l/  a0_�a/,FY }__Aa [m/  a1_�a/,FY `__Aa [aX/  a2_�a/,FY A__Aa [a �/  a3_�a/,FY "__Aa [a �/  a4_�a/,FY hW X��eE`Y hO_�a [a5/j I 9_�a [_�a [a5/E/E`O_a6 _a7&_�a8,FY hW X��eE`Y hO_�a [a9/j I 9_�a [_�a [a9/E/E`O_a: _a7&_�a;,FY hW X��eE`Y hO_�a [a</j g W_�a [_�a [a</E/E`O__Da [k/  a*_�a=,FY  __Da [l/  a,_�a=,FY hW X��eE`Y hO_�a [a>/j g W_�a [_�a [a>/E/E`O__Ga [k/  a*_�a?,FY  __Ga [l/  a,_�a?,FY hW X��eE`Y hO_�a [a@/j I 9_�a [_�a [a@/E/E`O_aA _a7&_�aB,FY hW X��eE`Y hO_�a [aC/j I 9_�a [_�a [aC/E/E`O_aD _a7&_�aE,FY hW X��eE`Y hO_�a [aF/j I 9_�a [_�a [aF/E/E`O_aG _a7&_�aH,FY hW X��eE`Y hO_ �_�	 _�a [aI/ja& � �_�a [_�a [aI/E/E`O__Ma [k/  aJ_�aK,FY {__Ma [l/  aL_�aK,FY ^__Ma [m/  aM_�aK,FY A__Ma [aX/  aN_�aK,FY "__Ma [a �/  aO_�aK,FY hW X��eE`Y hO_ �_�	 _�a [aP/ja& g W_�a [_�a [aP/E/E`O__Pa [k/  a*_�aQ,FY  __Pa [l/  a,_�aQ,FY hW X��eE`Y hO_ �_�	 _�a [aR/ja& g W_�a [_�a [aR/E/E`O__Sa [k/  aS_�aT,FY  __Sa [l/  aU_�aT,FY hW X��eE`Y hO_ �_�	 _�a [a {/ja& � �_�a [_�a [a {/E/E`O__Ya [k/  aV_�aW,FY \__Ya [l/  aX_�aW,FY ?__Ya [m/  aY_�aW,FY "__Ya [aX/  aZ_�aW,FY hW X��eE`Y hO_ �_�	 _�a [a[/ja& E 5_�a [_�a [a[/E/E`O_a\ __�a],FY hW X��eE`Y hO_ �_�	 _�a [a^/ja& I 9_�a [_�a [a^/E/E`O_a_ _a7&_�a`,FY hW X��eE`Y hO_ �_�	 _�a [aa/ja& I 9_�a [_�a [aa/E/E`O_ab _a7&_�ac,FY hW X��eE`Y hO_ �_�	 _�a [ad/ja& I 9_�a [_�a [ad/E/E`O_ae _a&_�af,FY hW X��eE`Y hO_ �_�	 _�a [ag/ja& I 9_�a [_�a [ag/E/E`O_ah _a&_�ai,FY hW X��eE`Y hO_ �_�	 _�a [aj/ja& c S_�a [_�a [aj/E/E`O__\a [k/  e_�ak,FY __\a [l/  f_�ak,FY hW X��eE`Y hO_ �_�	 _�a [al/ja& g W_�a [_�a [al/E/E`O__ba [k/  a*_�am,FY  __ba [l/  a,_�am,FY hW X��eE`Y hO_ �_�	 _�a [an/ja& g W_�a [_�a [an/E/E`O__ea [k/  ao_�ap,FY  __ea [l/  aq_�ap,FY hW X��eE`Y hO_ �_�	 _�a [ar/ja& c S_�a [_�a [ar/E/E`O__ha [k/  e_�as,FY __ha [l/  f_�as,FY hW X��eE`Y hO_ �_�	 _�a [at/ja& I 9_�a [_�a [at/E/E`O_au _a7&_�av,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& c S_�a [_�a [a�/E/E`O__na [k/  e_�aw,FY __na [l/  f_�aw,FY hW X��eE`Y hO_ �_�	 _�a [ax/ja& c S_�a [_�a [ax/E/E`O__qa [k/  e_�ay,FY __qa [l/  f_�ay,FY hW X��eE`Y hO_ �_�	 _�a [az/ja& I 9_�a [_�a [az/E/E`O_a{ _a&_�a|,FY hW X��eE`Y hO_ �_�	 _�a [a}/ja& I 9_�a [_�a [a}/E/E`O_a~ _a&_�a,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a&_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a&_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a&_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a&_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& c S_�a [_�a [a�/E/E`O__za [k/  e_�a�,FY __za [l/  f_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& c S_�a [_�a [a�/E/E`O__}a [k/  e_�a�,FY __}a [l/  f_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a?/ja& c S_�a [_�a [a?/E/E`O__�a [k/  e_�a�,FY __�a [l/  f_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& c S_�a [_�a [a�/E/E`O__�a [k/  e_�a�,FY __�a [l/  f_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja&  �_�a [_�a [a�/E/E`O__�a [k/  a._�a�,FY �__�a [l/  a0_�a�,FY �__�a [m/  a1_�a�,FY __�a [aX/  a2_�a�,FY `__�a [a �/  a3_�a�,FY A__�a [a �/  a4_�a�,FY "__�a [a�/  a�_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO_ �_�	 _�a [a�/ja& M =_�a [_�a [a�/E/E`O_a� _a7&a�_�a�,FY hW X��eE`Y hO_ _�	 _�a [a�/ja& m ]_�a [_�a [a�/E/E`O_a� 8_�a�,a� _a7&_�a�,FY _a7&a�_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& g W_�a [_�a [a�/E/E`O__�a [k/  a*_�a�,FY  __�a [l/  a,_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& ~ n_�a [_�a [a�/E/E`O_
_ E ?l_
j \lh __
a [�/  _
a [�k/a7&_�a�,FOY h[OY��Y eE`W X��eE`Y hO__�	 _�a [a�/ja& ~ n_�a [_�a [a�/E/E`O_@_ E ?l_@j \lh __@a [�/  _@a [�k/a7&_�a�,FOY h[OY��Y eE`W X��eE`Y hO__�	 _�a [a�/ja& E 5_�a [_�a [a�/E/E`O_a� __�a�,FY hW X��eE`Y hO_
_�	 _�a [a�/ja& E 5_�a [_�a [a�/E/E`O_a� __�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& E 5_�a [_�a [a�/E/E`O_a� __�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a7&_�a�,FY hW X��eE`Y hO__�	 _�a [a�/ja& c S_�a [_�a [a�/E/E`O__�a [k/  e_�a�,FY __�a [l/  f_�a�,FY hW X��eE`Y hO_ _�	 _�a [a�/ja& E 5_�a [_�a [a�/E/E`O_a� __�a�,FY hW X��eE`Y hO_$_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a&_�a�,FY hW X��eE`Y hO_*_�	 _�a [a�/ja& I 9_�a [_�a [a�/E/E`O_a� _a&_�a�,FY hW X��eE`Y hO_,_�	 _�a [a V/ja& E 5_�a [_�a [a V/E/E`O_a� __�a�,FY hW X��eE`Y hO_�a [a�/j X H_�a [_�a [a�/E/E`O_a� #_�a [_�a [l/E/_D6GO__D6GY hW X��eE`Y hO_0_� � �_ b[a Za [l \kh a���,FO_�a [�/a�k/E`�Oa���,FO f_�a [�/a� S_�a�k/a7&E`�O_�a�l/a7&E`�O_�a [�/a&E`�O_�a�_�a�_�a�_�a ��Y hW X��eE`[OY�gO_���,FY hO_e  �_�a�,a ]&E`�O_�a� a�_�%_�a�,FY a�_�a�,FO_Ca�  p_�a�,a ]&E`O_a� 2__%_%a�%�%a�%_�%a�%_�%a�%_�a�,FY #a�%a�%_�%a�%_�%a�%_�a�,FY hY hOPO�a�#j 	 _Сa[a& �*j�a�,_�a7&E`�O)_�k+�E`�Oa�a�,e  Oa�_�%a�%�%a ]&a�%_�%a ]&a�%aI�aJkaKa�a�lvaOa�aQa�a�ka �TY hY hOP[OY�2O Xk_Dj \lh  =_Da [�/E` O_Da [�k/E`O*a,a_ /a*a_/6lW X��h[OY��OPUO*j�a�,_�a7&E`�O)_�k+�E`�O*j�Oa_�%a%aI�aJkaKakvaOaa�a�aSTOPUO���,FOPW X�	���,Fascr  ��ޭ