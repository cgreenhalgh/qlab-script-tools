FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l      �� 	 
��   	�� Make a text file from cues: ingest/make a tab-delimited text file and populate (a copy of) it with a report of the cues in the current workspace in QLab;
    see second & third display dialogs for further explanation
 
This script is not designed to be run from within QLab!
 
v0.9: 12/10/09 Rich Walsh (with thanks to Jeremy Lee for some of the basic concepts)
v0.9.1: 16/10/09 Now "tested" in Snow Leopard; expanded makeNiceT for hours; fixed nasty mess with missing cue/file target strings;
        added Excel cleanup if renaming levels columns; made progress updates more frequent; general tidying - including first attempts at improving efficiency;
        updates for QLab 2.2.5
v0.9.2: 27/10/09 Added MSC translation; numerous typos
v1.0: 11/01/10 Fixed text-cleaning routines; "start value" is read-only, so fixed that; byte combo (and related) origin offset; corrected minor typos;
        added tell front workspace for elegance; wrapped text for better wiki experience; implemented dialogTitle for cross-script pillaging
v1.1: 31/01/10 Fixed a bug (!) with carriage returns in notes
 
<<< Last tested with: QLab 2.2.6; Mac OS 10.5.8 & 10.6.2; Microsoft Excel 12.2.0 (tested with Mac OS 10.5.8 only) >>>
 
<<< A LITTLE DISCLAIMER: This was quite a complex bit of work for me, so I make no guarantees whatsoever that it will work for you: if it does, use it;
    if it doesn't, I'd like to know, but I may choose not to do anything about it... >>>
 
***CUSTOMISATION***
 
This script has been designed to be highly customisable: you have control over what properties are reported, what the columns are called,
how QLab's constants are displayed and some other little tweaks too. However, you should record what you've done so you can repeat it
if the script ever gets updated, and please DON'T release your private version into the wild! 
 
To change what properties are reported, you can make your own text file or add/modify "presets" below. If, say, you add one with
"set preset7 to {"file target"}" then make sure you add something to the end of availablePresets so you can choose it, and "preset7"
to the end of presetMapper so the script can find it.
 
To change what the columns are called, edit the relevant entry in the "set acceptableColumnHeaders" line, eg: change "continue mode" to "f/on"
if you prefer (just don't use commas - they identify level-setting columns). You'll need to do this in any presets that refer to that property too, mind.
 
To change how QLab's constants are returned, edit the contents of the relevant "set constantsXXX" line, eg: change "set constants10_continue_mode"
entries from "do_not_continue", "auto_continue" & "auto_follow" to "no", "a/c" & "a/f" if you prefer.
 
Further tweaks are possible under "Customisable reporting translations"; hopefully they're self-explanatory. You can even modify
the default settings for "Other" in the levels reporting dialogs: see "Level reporting dialog variables (customisable)".     
 �  4   M a k e   a   t e x t   f i l e   f r o m   c u e s :   i n g e s t / m a k e   a   t a b - d e l i m i t e d   t e x t   f i l e   a n d   p o p u l a t e   ( a   c o p y   o f )   i t   w i t h   a   r e p o r t   o f   t h e   c u e s   i n   t h e   c u r r e n t   w o r k s p a c e   i n   Q L a b ; 
         s e e   s e c o n d   &   t h i r d   d i s p l a y   d i a l o g s   f o r   f u r t h e r   e x p l a n a t i o n 
   
 T h i s   s c r i p t   i s   n o t   d e s i g n e d   t o   b e   r u n   f r o m   w i t h i n   Q L a b ! 
   
 v 0 . 9 :   1 2 / 1 0 / 0 9   R i c h   W a l s h   ( w i t h   t h a n k s   t o   J e r e m y   L e e   f o r   s o m e   o f   t h e   b a s i c   c o n c e p t s ) 
 v 0 . 9 . 1 :   1 6 / 1 0 / 0 9   N o w   " t e s t e d "   i n   S n o w   L e o p a r d ;   e x p a n d e d   m a k e N i c e T   f o r   h o u r s ;   f i x e d   n a s t y   m e s s   w i t h   m i s s i n g   c u e / f i l e   t a r g e t   s t r i n g s ; 
                 a d d e d   E x c e l   c l e a n u p   i f   r e n a m i n g   l e v e l s   c o l u m n s ;   m a d e   p r o g r e s s   u p d a t e s   m o r e   f r e q u e n t ;   g e n e r a l   t i d y i n g   -   i n c l u d i n g   f i r s t   a t t e m p t s   a t   i m p r o v i n g   e f f i c i e n c y ; 
                 u p d a t e s   f o r   Q L a b   2 . 2 . 5 
 v 0 . 9 . 2 :   2 7 / 1 0 / 0 9   A d d e d   M S C   t r a n s l a t i o n ;   n u m e r o u s   t y p o s 
 v 1 . 0 :   1 1 / 0 1 / 1 0   F i x e d   t e x t - c l e a n i n g   r o u t i n e s ;   " s t a r t   v a l u e "   i s   r e a d - o n l y ,   s o   f i x e d   t h a t ;   b y t e   c o m b o   ( a n d   r e l a t e d )   o r i g i n   o f f s e t ;   c o r r e c t e d   m i n o r   t y p o s ; 
                 a d d e d   t e l l   f r o n t   w o r k s p a c e   f o r   e l e g a n c e ;   w r a p p e d   t e x t   f o r   b e t t e r   w i k i   e x p e r i e n c e ;   i m p l e m e n t e d   d i a l o g T i t l e   f o r   c r o s s - s c r i p t   p i l l a g i n g 
 v 1 . 1 :   3 1 / 0 1 / 1 0   F i x e d   a   b u g   ( ! )   w i t h   c a r r i a g e   r e t u r n s   i n   n o t e s 
   
 < < <   L a s t   t e s t e d   w i t h :   Q L a b   2 . 2 . 6 ;   M a c   O S   1 0 . 5 . 8   &   1 0 . 6 . 2 ;   M i c r o s o f t   E x c e l   1 2 . 2 . 0   ( t e s t e d   w i t h   M a c   O S   1 0 . 5 . 8   o n l y )   > > > 
   
 < < <   A   L I T T L E   D I S C L A I M E R :   T h i s   w a s   q u i t e   a   c o m p l e x   b i t   o f   w o r k   f o r   m e ,   s o   I   m a k e   n o   g u a r a n t e e s   w h a t s o e v e r   t h a t   i t   w i l l   w o r k   f o r   y o u :   i f   i t   d o e s ,   u s e   i t ; 
         i f   i t   d o e s n ' t ,   I ' d   l i k e   t o   k n o w ,   b u t   I   m a y   c h o o s e   n o t   t o   d o   a n y t h i n g   a b o u t   i t . . .   > > > 
   
 * * * C U S T O M I S A T I O N * * * 
   
 T h i s   s c r i p t   h a s   b e e n   d e s i g n e d   t o   b e   h i g h l y   c u s t o m i s a b l e :   y o u   h a v e   c o n t r o l   o v e r   w h a t   p r o p e r t i e s   a r e   r e p o r t e d ,   w h a t   t h e   c o l u m n s   a r e   c a l l e d , 
 h o w   Q L a b ' s   c o n s t a n t s   a r e   d i s p l a y e d   a n d   s o m e   o t h e r   l i t t l e   t w e a k s   t o o .   H o w e v e r ,   y o u   s h o u l d   r e c o r d   w h a t   y o u ' v e   d o n e   s o   y o u   c a n   r e p e a t   i t 
 i f   t h e   s c r i p t   e v e r   g e t s   u p d a t e d ,   a n d   p l e a s e   D O N ' T   r e l e a s e   y o u r   p r i v a t e   v e r s i o n   i n t o   t h e   w i l d !   
   
 T o   c h a n g e   w h a t   p r o p e r t i e s   a r e   r e p o r t e d ,   y o u   c a n   m a k e   y o u r   o w n   t e x t   f i l e   o r   a d d / m o d i f y   " p r e s e t s "   b e l o w .   I f ,   s a y ,   y o u   a d d   o n e   w i t h 
 " s e t   p r e s e t 7   t o   { " f i l e   t a r g e t " } "   t h e n   m a k e   s u r e   y o u   a d d   s o m e t h i n g   t o   t h e   e n d   o f   a v a i l a b l e P r e s e t s   s o   y o u   c a n   c h o o s e   i t ,   a n d   " p r e s e t 7 " 
 t o   t h e   e n d   o f   p r e s e t M a p p e r   s o   t h e   s c r i p t   c a n   f i n d   i t . 
   
 T o   c h a n g e   w h a t   t h e   c o l u m n s   a r e   c a l l e d ,   e d i t   t h e   r e l e v a n t   e n t r y   i n   t h e   " s e t   a c c e p t a b l e C o l u m n H e a d e r s "   l i n e ,   e g :   c h a n g e   " c o n t i n u e   m o d e "   t o   " f / o n " 
 i f   y o u   p r e f e r   ( j u s t   d o n ' t   u s e   c o m m a s   -   t h e y   i d e n t i f y   l e v e l - s e t t i n g   c o l u m n s ) .   Y o u ' l l   n e e d   t o   d o   t h i s   i n   a n y   p r e s e t s   t h a t   r e f e r   t o   t h a t   p r o p e r t y   t o o ,   m i n d . 
   
 T o   c h a n g e   h o w   Q L a b ' s   c o n s t a n t s   a r e   r e t u r n e d ,   e d i t   t h e   c o n t e n t s   o f   t h e   r e l e v a n t   " s e t   c o n s t a n t s X X X "   l i n e ,   e g :   c h a n g e   " s e t   c o n s t a n t s 1 0 _ c o n t i n u e _ m o d e " 
 e n t r i e s   f r o m   " d o _ n o t _ c o n t i n u e " ,   " a u t o _ c o n t i n u e "   &   " a u t o _ f o l l o w "   t o   " n o " ,   " a / c "   &   " a / f "   i f   y o u   p r e f e r . 
   
 F u r t h e r   t w e a k s   a r e   p o s s i b l e   u n d e r   " C u s t o m i s a b l e   r e p o r t i n g   t r a n s l a t i o n s " ;   h o p e f u l l y   t h e y ' r e   s e l f - e x p l a n a t o r y .   Y o u   c a n   e v e n   m o d i f y 
 t h e   d e f a u l t   s e t t i n g s   f o r   " O t h e r "   i n   t h e   l e v e l s   r e p o r t i n g   d i a l o g s :   s e e   " L e v e l   r e p o r t i n g   d i a l o g   v a r i a b l e s   ( c u s t o m i s a b l e ) " .        l     ��������  ��  ��        l     ��  ��    5 / ###FIXME### See 2x embedded comments in script     �   ^   # # # F I X M E # # #   S e e   2 x   e m b e d d e d   c o m m e n t s   i n   s c r i p t      l     ��  ��    x r ###FIXME### QLab throws an error when trying to get/set smpte format for an MSC Cue (checked in 2.2.6 Build 1084)     �   �   # # # F I X M E # # #   Q L a b   t h r o w s   a n   e r r o r   w h e n   t r y i n g   t o   g e t / s e t   s m p t e   f o r m a t   f o r   a n   M S C   C u e   ( c h e c k e d   i n   2 . 2 . 6   B u i l d   1 0 8 4 )      l     ��  ��    @ : ###FIXME### What happens if Excel isn't on the computer!?     �   t   # # # F I X M E # # #   W h a t   h a p p e n s   i f   E x c e l   i s n ' t   o n   t h e   c o m p u t e r ! ?      l     ��   ��    � � ###FIXME### QLab and/or the "script runner" is, generally, increasingly unresponsive to scripts the more cues there are in a workspace      � ! !   # # # F I X M E # # #   Q L a b   a n d / o r   t h e   " s c r i p t   r u n n e r "   i s ,   g e n e r a l l y ,   i n c r e a s i n g l y   u n r e s p o n s i v e   t o   s c r i p t s   t h e   m o r e   c u e s   t h e r e   a r e   i n   a   w o r k s p a c e   " # " l     �� $ %��   $ C = ###FIXME### Review dialogs in light of this (especially ETA)    % � & & z   # # # F I X M E # # #   R e v i e w   d i a l o g s   i n   l i g h t   o f   t h i s   ( e s p e c i a l l y   E T A ) #  ' ( ' l     �� ) *��   ) � � ###ADD### If the "Min" level from the Audio preferences page becomes scriptable then item 1 of minusInfinity could be pulled from the workspace    * � + +    # # # A D D # # #   I f   t h e   " M i n "   l e v e l   f r o m   t h e   A u d i o   p r e f e r e n c e s   p a g e   b e c o m e s   s c r i p t a b l e   t h e n   i t e m   1   o f   m i n u s I n f i n i t y   c o u l d   b e   p u l l e d   f r o m   t h e   w o r k s p a c e (  , - , l     �� . /��   . � � ###ADD### Other options for final file? Numbers, Bento, FileMaker Pro - don't hold your breath though (the first two currently have rubbish scripting hooks!)    / � 0 0<   # # # A D D # # #   O t h e r   o p t i o n s   f o r   f i n a l   f i l e ?   N u m b e r s ,   B e n t o ,   F i l e M a k e r   P r o   -   d o n ' t   h o l d   y o u r   b r e a t h   t h o u g h   ( t h e   f i r s t   t w o   c u r r e n t l y   h a v e   r u b b i s h   s c r i p t i n g   h o o k s ! ) -  1 2 1 l     ��������  ��  ��   2  3 4 3 l     �� 5 6��   5   Declarations    6 � 7 7    D e c l a r a t i o n s 4  8 9 8 l     ��������  ��  ��   9  : ; : p       < < ������ 0 dialogtitle dialogTitle��   ;  = > = l     ?���� ? r      @ A @ m      B B � C C 4 M a k e   a   t e x t   f i l e   f r o m   c u e s A o      ���� 0 dialogtitle dialogTitle��  ��   >  D E D l     ��������  ��  ��   E  F G F p       H H ������ 0 currenttids currentTIDs��   G  I J I l   	 K���� K r    	 L M L n    N O N 1    ��
�� 
txdl O 1    ��
�� 
ascr M o      ���� 0 currenttids currentTIDs��  ��   J  P Q P l     ��������  ��  ��   Q  R S R l  
 � T U V T r   
 � W X W J   
 � Y Y  Z [ Z m   
  \ \ � ] ]  t y p e [  ^ _ ^ m     ` ` � a a  q   n u m b e r _  b c b m     d d � e e  q   n a m e c  f g f m     h h � i i 
 n o t e s g  j k j m     l l � m m  c u e   t a r g e t k  n o n m     p p � q q  f i l e   t a r g e t o  r s r m     t t � u u  p r e   w a i t s  v w v m     x x � y y  d u r a t i o n w  z { z m     | | � } }  p o s t   w a i t {  ~  ~ m     � � � � �  c o n t i n u e   m o d e   � � � l 	   ����� � m     � � � � � 
 a r m e d��  ��   �  � � � m     � � � � �  m i d i   t r i g g e r �  � � � m     � � � � �  m i d i   c o m m a n d �  � � � m     � � � � �  m i d i   b y t e   o n e �  � � � m    ! � � � � �  m i d i   b y t e   t w o �  � � � m   ! $ � � � � �   t i m e c o d e   t r i g g e r �  � � � m   $ ' � � � � � $ w a l l   c l o c k   t r i g g e r �  � � � m   ' * � � � � �   w a l l   c l o c k   h o u r s �  � � � m   * - � � � � � $ w a l l   c l o c k   m i n u t e s �  � � � l 	 - 0 ����� � m   - 0 � � � � � $ w a l l   c l o c k   s e c o n d s��  ��   �  � � � m   0 3 � � � � �  m o d e �  � � � m   3 6 � � � � �   s y n c   t o   t i m e c o d e �  � � � m   6 9 � � � � �  s y n c   m o d e �  � � � m   9 < � � � � �  s m p t e   f o r m a t �  � � � m   < ? � � � � � ( m t c   s y n c   s o u r c e   n a m e �  � � � m   ? B � � � � �   l t c   s y n c   c h a n n e l �  � � � m   B E � � � � � 
 p a t c h �  � � � m   E H � � � � �  s t a r t   t i m e �  � � � m   H K � � � � �  e n d   t i m e �  � � � l 	 K N ����� � m   K N � � � � �  l o o p   s t a r t   t i m e��  ��   �  � � � m   N Q � � � � �  l o o p   e n d   t i m e �  � � � m   Q T � � � � �  l o o p   c o u n t �  � � � m   T W � � � � �  i n f i n i t e   l o o p �  � � � m   W Z � � � � �  g u a r a n t e e   s y n c �  � � � m   Z ] � � � � �  i n t e g r a t e d   f a d e �  � � � m   ] ` � � � � �  f a d e   m o d e �  � � � m   ` c � � � � � * s t o p   t a r g e t   w h e n   d o n e �  � � � m   c f � � � � �  a u t o   s t o p �  � � � m   f i � � � � � 
 l a y e r �  � � � l 	 i l ����� � m   i l � � � � �  f u l l   s c r e e n��  ��   �  � � � m   l o   � * p r e s e r v e   a s p e c t   r a t i o �  m   o r �  o p a c i t y  m   r u �		  t r a n s l a t i o n   x 

 m   u x �  t r a n s l a t i o n   y  m   x { �  r o t a t i o n  m   { ~ �  s c a l e   x  m   ~ � �  s c a l e   y  m   � � �  s c a l e   l o c k e d  m   � �   �!!   c u s t o m   r e n d e r i n g "#" m   � �$$ �%%  d o   o p a c i t y# &'& l 	 � �(����( m   � �)) �**  d o   t r a n s l a t i o n��  ��  ' +,+ m   � �-- �..  d o   r o t a t i o n, /0/ m   � �11 �22  d o   s c a l e0 343 m   � �55 �66  c o m m a n d4 787 m   � �99 �::  c h a n n e l8 ;<; m   � �== �>>  b y t e   o n e< ?@? m   � �AA �BB  b y t e   t w o@ CDC m   � �EE �FF  b y t e   c o m b oD GHG m   � �II �JJ  e n d   v a l u eH KLK m   � �MM �NN  f a d eL OPO m   � �QQ �RR  c o m m a n d   f o r m a tP STS l 	 � �U����U m   � �VV �WW  c o m m a n d   n u m b e r��  ��  T XYX m   � �ZZ �[[  q _ n u m b e rY \]\ m   � �^^ �__  q _ l i s t] `a` m   � �bb �cc  q _ p a t ha ded m   � �ff �gg 
 m a c r oe hih m   � �jj �kk  c o n t r o l   n u m b e ri lml m   � �nn �oo  c o n t r o l   v a l u em pqp m   � �rr �ss 
 h o u r sq tut m   � �vv �ww  m i n u t e su xyx m   � �zz �{{  s e c o n d sy |}| m   � �~~ �  f r a m e s} ��� m   � ��� ���  s u b f r a m e s� ��� l 	 � ������� m   � ��� ��� $ s e n d   t i m e   w i t h   s e t��  ��  � ��� m   � ��� ���  s y s e x   m e s s a g e� ��� m   � ��� ���   m i d i   d e s t i n a t i o n� ��� m   � ��� ��� " s t a r t   t i m e   o f f s e t� ��� m   � ��� ��� 8 f i r e   n e x t   c u e   w h e n   l o o p   e n d s� ��� m   � ��� ��� 4 s t o p   t a r g e t   w h e n   l o o p   e n d s� ��� m   � ��� ���  l o a d   t i m e� ���� l 	 � ������� m   � ��� ���  a s s i g n e d   n u m b e r��  ��  ��   X o      ���� 20 acceptablecolumnheaders acceptableColumnHeaders U [ U All possible properties (order is based on entries in QLab's AppleScript dictionary)    V ��� �   A l l   p o s s i b l e   p r o p e r t i e s   ( o r d e r   i s   b a s e d   o n   e n t r i e s   i n   Q L a b ' s   A p p l e S c r i p t   d i c t i o n a r y ) S ��� l     ��������  ��  ��  � ��� l  � ����� r   � ���� J   � ��� ���� m   � ��� ���  i s   i n   g r o u p��  � o      ���� *0 customcolumnheaders customColumnHeaders� 5 / Additional columns this script will understand   � ��� ^   A d d i t i o n a l   c o l u m n s   t h i s   s c r i p t   w i l l   u n d e r s t a n d� ��� l  ������� X   ������ s  ��� c  ��� o  ���� 0 eachitem eachItem� m  ��
�� 
TEXT� n      ���  ;  � o  ���� 20 acceptablecolumnheaders acceptableColumnHeaders�� 0 eachitem eachItem� o   � ���� *0 customcolumnheaders customColumnHeaders��  ��  � ��� l     ��������  ��  ��  � ��� l  4������ r   4��� J   0�� ��� m   #�� ���  u n i q u e   I D� ��� m  #&�� ���  b r o k e n� ��� m  &)�� ��� ( a u d i o   i n p u t   c h a n n e l s� ���� m  ),�� ���  s t a r t   v a l u e��  � o      ���� ,0 reportingonlycolumns reportingOnlyColumns��  ��  � ��� l 5Z������ X  5Z����� s  KU��� c  KP��� o  KL���� 0 eachitem eachItem� m  LO��
�� 
TEXT� n      ���  ;  ST� o  PS���� 20 acceptablecolumnheaders acceptableColumnHeaders�� 0 eachitem eachItem� o  8;���� ,0 reportingonlycolumns reportingOnlyColumns��  ��  � ��� l     ��������  ��  ��  � ��� l [a���� r  [a��� J  []����  � o      ���� 0 levelcolumns levelColumns� D > If a column header contains "," it will be added to this list   � ��� |   I f   a   c o l u m n   h e a d e r   c o n t a i n s   " , "   i t   w i l l   b e   a d d e d   t o   t h i s   l i s t� ��� l     ��������  ��  ��  � ��� l     ������  � F @ This is a list of properties that can be read for each cue type   � ��� �   T h i s   i s   a   l i s t   o f   p r o p e r t i e s   t h a t   c a n   b e   r e a d   f o r   e a c h   c u e   t y p e� ��� l     ��������  ��  ��  � ��� l     ������  � 9 3 set index2_q_number: every cue has q number (text)   � ��� f   s e t   i n d e x 2 _ q _ n u m b e r :   e v e r y   c u e   h a s   q   n u m b e r   ( t e x t )� ��� l     ������  � 5 / set index3_q_name: every cue has q name (text)   � ��� ^   s e t   i n d e x 3 _ q _ n a m e :   e v e r y   c u e   h a s   q   n a m e   ( t e x t )� ��� l     �� ��    3 - set index4_notes: every cue has notes (text)    � Z   s e t   i n d e x 4 _ n o t e s :   e v e r y   c u e   h a s   n o t e s   ( t e x t )�  l b� r  b�	 J  b�

  m  be �  F a d e  m  eh �  A n i m a t i o n  m  hk � 
 S t a r t  m  kn �  S t o p  m  nq � 
 P a u s e   m  qt!! �"" 
 R e s e t  #$# m  tw%% �&&  D e v a m p$ '(' m  wz)) �**  L o a d( +,+ m  z}-- �..  G o t o, /0/ m  }�11 �22  T a r g e t0 343 m  ��55 �66  A r m4 7��7 m  ��88 �99  D i s a r m��  	 o      ���� 0 index5_cue_target     (cue)    �::    ( c u e ) ;<; l ��=>?= r  ��@A@ J  ��BB CDC m  ��EE �FF 
 A u d i oD G��G m  ��HH �II 
 V i d e o��  A o      ���� 0 index6_file_target  >   (file)   ? �JJ    ( f i l e )< KLK l     ��MN��  M 9 3 set index7_pre_wait: every cue has pre wait (real)   N �OO f   s e t   i n d e x 7 _ p r e _ w a i t :   e v e r y   c u e   h a s   p r e   w a i t   ( r e a l )L PQP l ��RSTR r  ��UVU J  ��WW XYX m  ��ZZ �[[ 
 A u d i oY \]\ m  ��^^ �__  F a d e] `a` m  ��bb �cc 
 V i d e oa ded m  ��ff �gg  A n i m a t i o ne hih m  ��jj �kk  C a m e r ai lml m  ��nn �oo  M I D Im p��p m  ��qq �rr  W a i t��  V o      ���� 0 index8_duration  S > 8 Duration of Audio & Video cues can't be set, only read:   T �ss p   D u r a t i o n   o f   A u d i o   &   V i d e o   c u e s   c a n ' t   b e   s e t ,   o n l y   r e a d :Q tut l      ��vw��  v J D so this line is different from "Make cues from a text file" (real)    w �xx �   s o   t h i s   l i n e   i s   d i f f e r e n t   f r o m   " M a k e   c u e s   f r o m   a   t e x t   f i l e "   ( r e a l )  u yzy l     ��{|��  { ; 5 set index9_post_wait: every cue has post wait (real)   | �}} j   s e t   i n d e x 9 _ p o s t _ w a i t :   e v e r y   c u e   h a s   p o s t   w a i t   ( r e a l )z ~~ l     ������  � I C set index10_continue_mode: every cue has continue mode (constants)   � ��� �   s e t   i n d e x 1 0 _ c o n t i n u e _ m o d e :   e v e r y   c u e   h a s   c o n t i n u e   m o d e   ( c o n s t a n t s ) ��� l     ������  � 7 1 set index11_armed: every cue has armed (boolean)   � ��� b   s e t   i n d e x 1 1 _ a r m e d :   e v e r y   c u e   h a s   a r m e d   ( b o o l e a n )� ��� l     ������  � G A set index12_midi_trigger: every cue has midi trigger (constants)   � ��� �   s e t   i n d e x 1 2 _ m i d i _ t r i g g e r :   e v e r y   c u e   h a s   m i d i   t r i g g e r   ( c o n s t a n t s )� ��� l     ������  � G A set index13_midi_command: every cue has midi command (constants)   � ��� �   s e t   i n d e x 1 3 _ m i d i _ c o m m a n d :   e v e r y   c u e   h a s   m i d i   c o m m a n d   ( c o n s t a n t s )� ��� l     ������  � G A set index14_midi_byte_one: every cue has midi byte one (integer)   � ��� �   s e t   i n d e x 1 4 _ m i d i _ b y t e _ o n e :   e v e r y   c u e   h a s   m i d i   b y t e   o n e   ( i n t e g e r )� ��� l     ������  � G A set index15_midi_byte_two: every cue has midi byte two (integer)   � ��� �   s e t   i n d e x 1 5 _ m i d i _ b y t e _ t w o :   e v e r y   c u e   h a s   m i d i   b y t e   t w o   ( i n t e g e r )� ��� l     ������  � O I set index16_timecode_trigger: every cue has timecode trigger (constants)   � ��� �   s e t   i n d e x 1 6 _ t i m e c o d e _ t r i g g e r :   e v e r y   c u e   h a s   t i m e c o d e   t r i g g e r   ( c o n s t a n t s )� ��� l     ������  � S M set index17_wall_clock_trigger: every cue has wall clock trigger (constants)   � ��� �   s e t   i n d e x 1 7 _ w a l l _ c l o c k _ t r i g g e r :   e v e r y   c u e   h a s   w a l l   c l o c k   t r i g g e r   ( c o n s t a n t s )� ��� l     ������  � M G set index18_wall_clock_hours: every cue has wall clock hours (integer)   � ��� �   s e t   i n d e x 1 8 _ w a l l _ c l o c k _ h o u r s :   e v e r y   c u e   h a s   w a l l   c l o c k   h o u r s   ( i n t e g e r )� ��� l     ������  � Q K set index19_wall_clock_minutes: every cue has wall clock minutes (integer)   � ��� �   s e t   i n d e x 1 9 _ w a l l _ c l o c k _ m i n u t e s :   e v e r y   c u e   h a s   w a l l   c l o c k   m i n u t e s   ( i n t e g e r )� ��� l     ������  � Q K set index20_wall_clock_seconds: every cue has wall clock seconds (integer)   � ��� �   s e t   i n d e x 2 0 _ w a l l _ c l o c k _ s e c o n d s :   e v e r y   c u e   h a s   w a l l   c l o c k   s e c o n d s   ( i n t e g e r )� ��� l ������ r  ����� J  ���� ��� m  ���� ���  C u e   L i s t� ���� m  ���� ��� 
 G r o u p��  � o      ���� 0 index21_mode  �   (constants)   � ���    ( c o n s t a n t s )� ��� l ������ r  ����� J  ���� ���� m  ���� ���  C u e   L i s t��  � o      ���� 0 index22_sync_to_timecode  �   (constants)   � ���    ( c o n s t a n t s )� ��� l ������ r  ����� J  ���� ���� m  ���� ���  C u e   L i s t��  � o      ���� 0 index23_sync_mode  �   (constants)   � ���    ( c o n s t a n t s )� ��� l ������ r  ����� J  ���� ��� m  ���� ���  C u e   L i s t� ���� m  ���� ���  M T C��  � o      ���� 0 index24_smpte_format  � N H (constants) ###FIXME### "MSC" removed from list as QLab throws an error   � ��� �   ( c o n s t a n t s )   # # # F I X M E # # #   " M S C "   r e m o v e d   f r o m   l i s t   a s   Q L a b   t h r o w s   a n   e r r o r� ��� l ������ r  ����� J  ���� ���� m  ���� ���  C u e   L i s t��  � o      ��  0 index25_mtc_sync_source_name  �   (text)   � ���    ( t e x t )� ��� l ������ r  ����� J  ��   �~ m  �� �  C u e   L i s t�~  � o      �}�} 0 index26_ltc_sync_channel  �  
 (integer)   � �    ( i n t e g e r )�  l �	 r  �

 J  �  m  �� � 
 A u d i o  m  � � 
 V i d e o  m   �  C a m e r a  m   �  M I D I  m   �    M S C !�|! m  "" �##  M I D I   S y s E x�|   o      �{�{ 0 index27_patch    
 (integer)   	 �$$    ( i n t e g e r ) %&% l #'()' r  #*+* J  ,, -.- m  // �00 
 A u d i o. 1�z1 m  22 �33 
 V i d e o�z  + o      �y�y 0 index28_start_time  (   (real)   ) �44    ( r e a l )& 565 l $07897 r  $0:;: J  $,<< =>= m  $'?? �@@ 
 A u d i o> A�xA m  '*BB �CC 
 V i d e o�x  ; o      �w�w 0 index29_end_time  8   (real)   9 �DD    ( r e a l )6 EFE l 1:GHIG r  1:JKJ J  16LL M�vM m  14NN �OO 
 A u d i o�v  K o      �u�u 0 index30_loop_start_time  H   (real)   I �PP    ( r e a l )F QRQ l ;DSTUS r  ;DVWV J  ;@XX Y�tY m  ;>ZZ �[[ 
 A u d i o�t  W o      �s�s 0 index31_loop_end_time  T   (real)   U �\\    ( r e a l )R ]^] l EN_`a_ r  ENbcb J  EJdd e�re m  EHff �gg 
 A u d i o�r  c o      �q�q 0 index32_loop_count  `  
 (integer)   a �hh    ( i n t e g e r )^ iji l O[klmk r  O[non J  OWpp qrq m  ORss �tt 
 A u d i or u�pu m  RUvv �ww 
 V i d e o�p  o o      �o�o 0 index33_infinite_loop  l  
 (boolean)   m �xx    ( b o o l e a n )j yzy l \e{|}{ r  \e~~ J  \a�� ��n� m  \_�� ��� 
 A u d i o�n   o      �m�m 0 index34_guarantee_sync  |  
 (boolean)   } ���    ( b o o l e a n )z ��� l fo���� r  fo��� J  fk�� ��l� m  fi�� ��� 
 A u d i o�l  � o      �k�k 0 index35_integrated_fade  �   (constants)   � ���    ( c o n s t a n t s )� ��� l py���� r  py��� J  pu�� ��j� m  ps�� ���  F a d e�j  � o      �i�i 0 index36_fade_mode  �   (constants)   � ���    ( c o n s t a n t s )� ��� l z����� r  z���� J  z��� ��� m  z}�� ���  F a d e� ��h� m  }��� ���  A n i m a t i o n�h  � o      �g�g !0 index37_stop_target_when_done  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ������ r  ����� J  ���� ��f� m  ���� ��� 
 V i d e o�f  � o      �e�e 0 index38_auto_stop  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ������ r  ����� J  ���� ��� m  ���� ��� 
 V i d e o� ��d� m  ���� ���  C a m e r a�d  � o      �c�c 0 index39_layer  �  
 (integer)   � ���    ( i n t e g e r )� ��� l ������ r  ����� J  ���� ��� m  ���� ��� 
 V i d e o� ��b� m  ���� ���  C a m e r a�b  � o      �a�a 0 index40_full_screen  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ������ r  ����� J  ���� ��� m  ���� ��� 
 V i d e o� ��`� m  ���� ���  C a m e r a�`  � o      �_�_ !0 index41_preserve_aspect_ratio  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ������ r  ����� J  ���� ��� m  ���� ��� 
 V i d e o� ��� m  ���� ���  A n i m a t i o n� ��^� m  ���� ���  C a m e r a�^  � o      �]�] 0 index42_opacity  �   (real)   � ���    ( r e a l )� ��� l ��� � r  �� J  ��  m  �� � 
 V i d e o 	
	 m  �� �  A n i m a t i o n
 �\ m  �� �  C a m e r a�\   o      �[�[ 0 index43_translation_x      (real)    �    ( r e a l )�  l �� r  �� J  ��  m  �� � 
 V i d e o  m  �� �    A n i m a t i o n !�Z! m  ��"" �##  C a m e r a�Z   o      �Y�Y 0 index44_translation_y     (real)    �$$    ( r e a l ) %&% l ��'()' r  ��*+* J  ��,, -.- m  ��// �00 
 V i d e o. 121 m  ��33 �44  A n i m a t i o n2 5�X5 m  ��66 �77  C a m e r a�X  + o      �W�W 0 index45_rotation  (   (real)   ) �88    ( r e a l )& 9:9 l �;<=; r  �>?> J  �@@ ABA m  ��CC �DD 
 V i d e oB EFE m  ��GG �HH  A n i m a t i o nF I�VI m  �JJ �KK  C a m e r a�V  ? o      �U�U 0 index46_scale_x  <   (real)   = �LL    ( r e a l ): MNM l OPQO r  RSR J  TT UVU m  WW �XX 
 V i d e oV YZY m  [[ �\\  A n i m a t i o nZ ]�T] m  ^^ �__  C a m e r a�T  S o      �S�S 0 index47_scale_y  P   (real)   Q �``    ( r e a l )N aba l 'cdec r  'fgf J  #hh iji m  kk �ll 
 V i d e oj mnm m  oo �pp  A n i m a t i o nn q�Rq m  !rr �ss  C a m e r a�R  g o      �Q�Q 0 index48_scale_locked  d  
 (boolean)   e �tt    ( b o o l e a n )b uvu l (4wxyw r  (4z{z J  (0|| }~} m  (+ ��� 
 V i d e o~ ��P� m  +.�� ���  C a m e r a�P  { o      �O�O 0 index49_custom_rendering  x  
 (boolean)   y ���    ( b o o l e a n )v ��� l 5>���� r  5>��� J  5:�� ��N� m  58�� ���  A n i m a t i o n�N  � o      �M�M 0 index50_do_opacity  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ?H���� r  ?H��� J  ?D�� ��L� m  ?B�� ���  A n i m a t i o n�L  � o      �K�K 0 index51_do_translation  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l IR���� r  IR��� J  IN�� ��J� m  IL�� ���  A n i m a t i o n�J  � o      �I�I 0 index52_do_rotation  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l S\���� r  S\��� J  SX�� ��H� m  SV�� ���  A n i m a t i o n�H  � o      �G�G 0 index53_do_scale  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l ]f���� r  ]f��� J  ]b�� ��F� m  ]`�� ���  M I D I�F  � o      �E�E 0 index54_command  �   (constants)   � ���    ( c o n s t a n t s )� ��� l gp���� r  gp��� J  gl�� ��D� m  gj�� ���  M I D I�D  � o      �C�C 0 index55_channel  �  
 (integer)   � ���    ( i n t e g e r )� ��� l qz���� r  qz��� J  qv�� ��B� m  qt�� ���  M I D I�B  � o      �A�A 0 index56_byte_one  �  
 (integer)   � ���    ( i n t e g e r )� ��� l {����� r  {���� J  {��� ��@� m  {~�� ���  M I D I�@  � o      �?�? 0 index57_byte_two  �  
 (integer)   � ���    ( i n t e g e r )� ��� l ������ r  ����� J  ���� ��>� m  ���� ���  M I D I�>  � o      �=�= 0 index58_byte_combo  �  
 (integer)   � ���    ( i n t e g e r )� ��� l ������ r  ����� J  ���� ��<� m  ���� ���  M I D I�<  � o      �;�; 0 index59_end_value  �  
 (integer)   � ���    ( i n t e g e r )� ��� l ��� � r  �� J  �� �: m  �� �  M I D I�:   o      �9�9 0 index60_fade      (constants)    �    ( c o n s t a n t s )� 	
	 l �� r  �� J  �� �8 m  �� �  M S C�8   o      �7�7 0 index61_command_format    
 (integer)    �    ( i n t e g e r )
  l �� r  �� J  �� �6 m  �� �  M S C�6   o      �5�5 0 index62_command_number    
 (integer)    �      ( i n t e g e r ) !"! l ��#$%# r  ��&'& J  ��(( )�4) m  ��** �++  M S C�4  ' o      �3�3 0 index63_q__number  $   (text)   % �,,    ( t e x t )" -.- l ��/01/ r  ��232 J  ��44 5�25 m  ��66 �77  M S C�2  3 o      �1�1 0 index64_q__list  0   (text)   1 �88    ( t e x t ). 9:9 l ��;<=; r  ��>?> J  ��@@ A�0A m  ��BB �CC  M S C�0  ? o      �/�/ 0 index65_q__path  <   (text)   = �DD    ( t e x t ): EFE l ��GHIG r  ��JKJ J  ��LL M�.M m  ��NN �OO  M S C�.  K o      �-�- 0 index66_macro  H  
 (integer)   I �PP    ( i n t e g e r )F QRQ l ��STUS r  ��VWV J  ��XX Y�,Y m  ��ZZ �[[  M S C�,  W o      �+�+ 0 index67_control_number  T  
 (integer)   U �\\    ( i n t e g e r )R ]^] l ��_`a_ r  ��bcb J  ��dd e�*e m  ��ff �gg  M S C�*  c o      �)�) 0 index68_control_value  `  
 (integer)   a �hh    ( i n t e g e r )^ iji l ��klmk r  ��non J  ��pp q�(q m  ��rr �ss  M S C�(  o o      �'�' 0 index69_hours  l  
 (integer)   m �tt    ( i n t e g e r )j uvu l �wxyw r  �z{z J  �|| }�&} m  � ~~ �  M S C�&  { o      �%�% 0 index70_minutes  x  
 (integer)   y ���    ( i n t e g e r )v ��� l ���� r  ��� J  �� ��$� m  
�� ���  M S C�$  � o      �#�# 0 index71_seconds  �  
 (integer)   � ���    ( i n t e g e r )� ��� l ���� r  ��� J  �� ��"� m  �� ���  M S C�"  � o      �!�! 0 index72_frames  �  
 (integer)   � ���    ( i n t e g e r )� ��� l $���� r  $��� J   �� �� � m  �� ���  M S C�   � o      �� 0 index73_subframes  �  
 (integer)   � ���    ( i n t e g e r )� ��� l %.���� r  %.��� J  %*�� ��� m  %(�� ���  M S C�  � o      �� 0 index74_send_time_with_set  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l /8���� r  /8��� J  /4�� ��� m  /2�� ���  M I D I   S y s E x�  � o      �� 0 index75_sysex_message  �   (text)   � ���    ( t e x t )� ��� l 9B���� r  9B��� J  9>�� ��� m  9<�� ���  M T C�  � o      �� 0 index76_midi_destination  �   (text)   � ���    ( t e x t )� ��� l CL���� r  CL��� J  CH�� ��� m  CF�� ���  M T C�  � o      �� 0 index77_start_time_offset  �   (real)   � ���    ( r e a l )� ��� l MV���� r  MV��� J  MR�� ��� m  MP�� ���  D e v a m p�  � o      �� (0 $index78_fire_next_cue_when_loop_ends  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l W`���� r  W`��� J  W\�� ��� m  WZ�� ���  D e v a m p�  � o      �� &0 "index79_stop_target_when_loop_ends  �  
 (boolean)   � ���    ( b o o l e a n )� ��� l aj���� r  aj��� J  af�� ��� m  ad�� ���  L o a d�  � o      �� 0 index80_load_time  �   (real)   � ���    ( r e a l )� ��� l kt���� r  kt��� J  kp   � m  kn �  T a r g e t�  � o      �� 0 index81_assigned_number  �   (text)   � �    ( t e x t )�  l     ��   h b set index82: "is in group" is a custom column for this script that has no direct meaning for QLab    �		 �   s e t   i n d e x 8 2 :   " i s   i n   g r o u p "   i s   a   c u s t o m   c o l u m n   f o r   t h i s   s c r i p t   t h a t   h a s   n o   d i r e c t   m e a n i n g   f o r   Q L a b 

 l     ��   ; 5set index83_unique ID: every cue has unique ID (text)    � j s e t   i n d e x 8 3 _ u n i q u e   I D :   e v e r y   c u e   h a s   u n i q u e   I D   ( t e x t )  l     ��   8 2set index84_broken: every cue has broken (boolean)    � d s e t   i n d e x 8 4 _ b r o k e n :   e v e r y   c u e   h a s   b r o k e n   ( b o o l e a n )  l u� r  u� J  u}  m  ux � 
 A u d i o  �  m  x{!! �"" 
 V i d e o�   o      �
�
  0 index85_audio_input_channels    
 (integer)    �##    ( i n t e g e r ) $%$ l ��&'(& r  ��)*) J  ��++ ,�	, m  ��-- �..  M I D I�	  * o      �� 0 index86_start_value  '  
 (integer)   ( �//    ( i n t e g e r )% 010 l     ����  �  �  1 232 l ��4564 r  ��787 J  ��99 :;: m  ��<< �== 
 A u d i o; >?> m  ��@@ �AA  F a d e? B�B m  ��CC �DD 
 V i d e o�  8 o      ��  0 index_setlevel index_setLevel5 6 0 Special private index for custom column headers   6 �EE `   S p e c i a l   p r i v a t e   i n d e x   f o r   c u s t o m   c o l u m n   h e a d e r s3 FGF l     ��� �  �  �   G HIH l     ��JK��  J x r This is a list of values for any constants (which can be used to customise the entries returned in the text file)   K �LL �   T h i s   i s   a   l i s t   o f   v a l u e s   f o r   a n y   c o n s t a n t s   ( w h i c h   c a n   b e   u s e d   t o   c u s t o m i s e   t h e   e n t r i e s   r e t u r n e d   i n   t h e   t e x t   f i l e )I MNM l     ��������  ��  ��  N OPO l ��Q����Q r  ��RSR J  ��TT UVU m  ��WW �XX  d o _ n o t _ c o n t i n u eV YZY m  ��[[ �\\  a u t o _ c o n t i n u eZ ]��] m  ��^^ �__  a u t o _ f o l l o w��  S o      ���� 0 constants10_continue_mode  ��  ��  P `a` l ��b����b r  ��cdc J  ��ee fgf m  ��hh �ii  t r u eg j��j m  ��kk �ll 
 f a l s e��  d o      ���� 0 constants11_armed  ��  ��  a mnm l ��o����o r  ��pqp J  ��rr sts m  ��uu �vv  e n a b l e dt w��w m  ��xx �yy  d i s a b l e d��  q o      ���� 0 constants12_midi_trigger  ��  ��  n z{z l ��|����| r  ��}~} J  �� ��� m  ���� ���  n o t e _ o n� ��� m  ���� ���  n o t e _ o f f� ��� m  ���� ���  p r o g r a m _ c h a n g e� ��� m  ���� ���  c o n t r o l _ c h a n g e� ��� m  ���� ���  k e y _ p r e s s u r e� ���� m  ���� ���   c h a n n e l _ p r e s s u r e��  ~ o      ���� 0 constants13_midi_command  ��  ��  { ��� l �������� r  ����� J  ���� ��� m  ���� ���  e n a b l e d� ���� m  ���� ���  d i s a b l e d��  � o      ����  0 constants16_timecode_trigger  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  e n a b l e d� ���� m  ���� ���  d i s a b l e d��  � o      ���� "0 constants17_wall_clock_trigger  ��  ��  � ��� l ������� r  ���� J  ��� ��� m  ���� ���  c u e _ l i s t� ��� m  ��� ��� , f i r e _ f i r s t _ e n t e r _ g r o u p� ��� m  �� ��� 2 f i r e _ f i r s t _ g o _ t o _ n e x t _ c u e� ��� m  �� ���  f i r e _ a l l� ���� m  
�� ���  f i r e _ r a n d o m��  � o      ���� 0 constants21_mode  ��  ��  � ��� l ������ r  ��� J  �� ��� m  �� ���  e n a b l e d� ���� m  �� ���  d i s a b l e d��  � o      ����  0 constants22_sync_to_timecode  ��  ��  � ��� l  ,������ r   ,��� J   (�� ��� m   #�� ���  m t c� ���� m  #&�� ���  l t c��  � o      ���� 0 constants23_sync_mode  ��  ��  � ��� l -A������ r  -A��� J  -=�� ��� m  -0�� ���  f p s _ 2 4� ��� m  03�� ���  f p s _ 2 5� ��� m  36�� ���  f p s _ 3 0 _ d r o p� ���� m  69�� ���  f p s _ 3 0 _ n o n _ d r o p��  � o      ���� 0 constants24_smpte_format  ��  ��  � ��� l BN������ r  BN��� J  BJ�� � � m  BE �  t r u e  �� m  EH � 
 f a l s e��  � o      ���� 0 constants33_infinite_loop  ��  ��  �  l O[���� r  O[	
	 J  OW  m  OR �  t r u e �� m  RU � 
 f a l s e��  
 o      ���� 0 constants34_guarantee_sync  ��  ��    l \h���� r  \h J  \d  m  \_ �  e n a b l e d �� m  _b �  d i s a b l e d��   o      ���� 0 constants35_integrated_fade  ��  ��    !  l iu"����" r  iu#$# J  iq%% &'& m  il(( �))  a b s o l u t e' *��* m  lo++ �,,  r e l a t i v e��  $ o      ���� 0 constants36_fade_mode  ��  ��  ! -.- l v�/����/ r  v�010 J  v~22 343 m  vy55 �66  t r u e4 7��7 m  y|88 �99 
 f a l s e��  1 o      ���� %0 !constants37_stop_target_when_done  ��  ��  . :;: l ��<����< r  ��=>= J  ��?? @A@ m  ��BB �CC  t r u eA D��D m  ��EE �FF 
 f a l s e��  > o      ���� 0 constants38_auto_stop  ��  ��  ; GHG l ��I����I r  ��JKJ J  ��LL MNM m  ��OO �PP  t r u eN Q��Q m  ��RR �SS 
 f a l s e��  K o      ���� 0 constants40_full_screen  ��  ��  H TUT l ��V����V r  ��WXW J  ��YY Z[Z m  ��\\ �]]  t r u e[ ^��^ m  ��__ �`` 
 f a l s e��  X o      ���� %0 !constants41_preserve_aspect_ratio  ��  ��  U aba l ��c����c r  ��ded J  ��ff ghg m  ��ii �jj  t r u eh k��k m  ��ll �mm 
 f a l s e��  e o      ���� 0 constants48_scale_locked  ��  ��  b non l ��p����p r  ��qrq J  ��ss tut m  ��vv �ww  t r u eu x��x m  ��yy �zz 
 f a l s e��  r o      ����  0 constants49_custom_rendering  ��  ��  o {|{ l ��}����} r  ��~~ J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��   o      ���� 0 constants50_do_opacity  ��  ��  | ��� l �������� r  ����� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ���� 0 constants51_do_translation  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ���� 0 constants52_do_rotation  ��  ��  � ��� l �������� r  ����� J  ���� ��� m  ���� ���  t r u e� ���� m  ���� ��� 
 f a l s e��  � o      ���� 0 constants53_do_scale  ��  ��  � ��� l ������� r  ���� J  ��� ��� m  ���� ���  n o t e _ o n� ��� m  ���� ���  n o t e _ o f f� ��� m  ��� ���  p r o g r a m _ c h a n g e� ��� m  �� ���  c o n t r o l _ c h a n g e� ��� m  �� ���  k e y _ p r e s s u r e� ��� m  
�� ���   c h a n n e l _ p r e s s u r e� ���� m  
�� ���  p i t c h _ b e n d��  � o      ���� 0 constants54_command  ��  ��  � ��� l "������ r  "��� J  �� ��� m  �� ���  e n a b l e d� ���� m  �� ���  d i s a b l e d��  � o      ���� 0 constants60_fade  ��  ��  � ��� l #/������ r  #/��� J  #+�� ��� m  #&�� ���  t r u e� ���� m  &)�� ��� 
 f a l s e��  � o      ���� "0 constants74_send_time_with_set  ��  ��  � ��� l 0<������ r  0<��� J  08�� ��� m  03�� ���  t r u e� ���� m  36�� ��� 
 f a l s e��  � o      ���� ,0 (constants78_fire_next_cue_when_loop_ends  ��  ��  � ��� l =I������ r  =I��� J  =E�� ��� m  =@�� �    t r u e� �� m  @C � 
 f a l s e��  � o      ���� *0 &constants79_stop_target_when_loop_ends  ��  ��  �  l JV���� r  JV J  JR		 

 m  JM �  t r u e �� m  MP � 
 f a l s e��   o      ���� 0 constants84_broken  ��  ��    l     ��������  ��  ��    l     ����   F @ These variables are used to translate MSC integers into English    � �   T h e s e   v a r i a b l e s   a r e   u s e d   t o   t r a n s l a t e   M S C   i n t e g e r s   i n t o   E n g l i s h  l     ��~�}�  �~  �}    l W��|�{ r  W� J  W�  !  m  WZ"" �##  1! $%$ m  Z]&& �'' $ L i g h t i n g   ( G e n e r a l )% ()( m  ]`** �++  2) ,-, m  `c.. �//  M o v i n g   L i g h t s- 010 m  cf22 �33  31 454 m  fi66 �77  C o l o r   C h a n g e r s5 898 m  il:: �;;  49 <=< m  lo>> �??  S t r o b e s= @A@ m  orBB �CC  5A DED m  ruFF �GG  L a s e r sE HIH m  uxJJ �KK  6I LML m  x{NN �OO  C h a s e r sM PQP l 	{~R�z�yR m  {~SS �TT  1 6�z  �y  Q UVU m  ~�WW �XX  S o u n d   ( G e n e r a l )V YZY m  ��[[ �\\  1 7Z ]^] m  ��__ �`` 
 M u s i c^ aba m  ��cc �dd  1 8b efe m  ��gg �hh  C D   P l a y e r sf iji m  ��kk �ll  1 9j mnm m  ��oo �pp  E P R O M   P l a y b a c kn qrq m  ��ss �tt  2 0r uvu m  ��ww �xx & A u d i o   T a p e   M a c h i n e sv yzy m  ��{{ �||  2 1z }~} m  �� ���  I n t e r c o m s~ ��� m  ���� ���  2 2� ��� m  ���� ���  A m p l i f i e r s� ��� l 	����x�w� m  ���� ���  2 3�x  �w  � ��� m  ���� ��� * A u d i o   E f f e c t s   D e v i c e s� ��� m  ���� ���  2 4� ��� m  ���� ���  E q u a l i z e r s� ��� m  ���� ���  3 2� ��� m  ���� ��� & M a c h i n e r y   ( G e n e r a l )� ��� m  ���� ���  3 3� ��� m  ���� ���  R i g g i n g� ��� m  ���� ���  3 4� ��� m  ���� ���  F l y s� ��� m  ���� ���  3 5� ��� m  ���� ��� 
 L i f t s� ��� m  ���� ���  3 6� ��� m  ���� ���  T u r n t a b l e s� ��� m  ���� ���  3 7� ��� m  ���� ���  T r u s s e s� ��� l 	����v�u� m  ���� ���  3 8�v  �u  � ��� m  ���� ���  R o b o t s� ��� m  ���� ���  3 9� ��� m  ���� ���  A n i m a t i o n� ��� m  ���� ���  4 0� ��� m  ���� ���  F l o a t s� ��� m  ���� ���  4 1� ��� m  ���� ���  B r e a k a w a y s� ��� m  ���� ���  4 2� ��� m  ���� ���  B a r g e s� ��� m  ���� ���  4 8� ��� m  ���� ���  V i d e o   ( G e n e r a l )� ��� m  ���� ���  4 9� �	 � m  ��		 �		 & V i d e o   T a p e   M a c h i n e s	  			 l 	�	�t�s	 m  �		 �		  5 0�t  �s  	 				 m  	
	
 �		 . V i d e o   C a s s e t t e   M a c h i n e s		 			 m  		 �		  5 1	 			 m  		 �		 $ V i d e o   D i s c   P l a y e r s	 			 m  		 �		  5 2	 			 m  		 �		  V i d e o   S w i t c h e r s	 			 m  		 �		  5 3	 	 	!	  m  	"	" �	#	#  V i d e o   E f f e c t s	! 	$	%	$ m  	&	& �	'	'  5 4	% 	(	)	( m  	*	* �	+	+ 4 V i d e o   C h a r a c t e r   G e n e r a t o r s	) 	,	-	, l 	 	.�r�q	. m   	/	/ �	0	0  5 5�r  �q  	- 	1	2	1 m   #	3	3 �	4	4 $ V i d e o   S t i l l   S t o r e s	2 	5	6	5 m  #&	7	7 �	8	8  5 6	6 	9	:	9 m  &)	;	; �	<	<  V i d e o   M o n i t o r s	: 	=	>	= m  ),	?	? �	@	@  6 4	> 	A	B	A m  ,/	C	C �	D	D ( P r o j e c t i o n   ( G e n e r a l )	B 	E	F	E m  /2	G	G �	H	H  6 5	F 	I	J	I m  25	K	K �	L	L  F i l m   P r o j e c t o r s	J 	M	N	M m  58	O	O �	P	P  6 6	N 	Q	R	Q m  8;	S	S �	T	T   S l i d e   P r o j e c t o r s	R 	U	V	U m  ;>	W	W �	X	X  6 7	V 	Y	Z	Y m  >A	[	[ �	\	\   V i d e o   P r o j e c t o r s	Z 	]	^	] l 	AD	_�p�o	_ m  AD	`	` �	a	a  6 8�p  �o  	^ 	b	c	b m  DG	d	d �	e	e  D i s s o l v e r s	c 	f	g	f m  GJ	h	h �	i	i  6 9	g 	j	k	j m  JM	l	l �	m	m   S h u t t e r   C o n t r o l s	k 	n	o	n m  MP	p	p �	q	q  8 0	o 	r	s	r m  PS	t	t �	u	u 2 P r o c e s s   C o n t r o l   ( G e n e r a l )	s 	v	w	v m  SV	x	x �	y	y  8 1	w 	z	{	z m  VY	|	| �	}	}  H y d r a u l i c   O i l	{ 	~		~ m  Y\	�	� �	�	�  8 2	 	�	�	� m  \_	�	� �	�	�  H 2 O	� 	�	�	� m  _b	�	� �	�	�  8 3	� 	�	�	� m  be	�	� �	�	�  C O 2	� 	�	�	� m  eh	�	� �	�	�  8 4	� 	�	�	� m  hk	�	� �	�	�  C o m p r e s s e d   A i r	� 	�	�	� l 	kn	��n�m	� m  kn	�	� �	�	�  8 5�n  �m  	� 	�	�	� m  nq	�	� �	�	�  N a t u r a l   G a s	� 	�	�	� m  qt	�	� �	�	�  8 6	� 	�	�	� m  tw	�	� �	�	�  F o g	� 	�	�	� m  wz	�	� �	�	�  8 7	� 	�	�	� m  z}	�	� �	�	� 
 S m o k e	� 	�	�	� m  }�	�	� �	�	�  8 8	� 	�	�	� m  ��	�	� �	�	�  C r a c k e d   H a z e	� 	�	�	� m  ��	�	� �	�	�  9 6	� 	�	�	� m  ��	�	� �	�	� , P y r o t e c h n i c s   ( G e n e r a l )	� 	�	�	� m  ��	�	� �	�	�  9 7	� 	�	�	� m  ��	�	� �	�	�  F i r e w o r k s	� 	�	�	� m  ��	�	� �	�	�  9 8	� 	�	�	� m  ��	�	� �	�	�  E x p l o s i o n s	� 	�	�	� m  ��	�	� �	�	�  9 9	� 	�	�	� m  ��	�	� �	�	� 
 F l a m e	� 	�	�	� l 	��	��l�k	� m  ��	�	� �	�	�  1 0 0�l  �k  	� 	�	�	� m  ��	�	� �	�	�  S m o k e   P o t s	� 	�	�	� m  ��	�	� �	�	�  1 2 7	� 	��j	� m  ��	�	� �	�	�  A l l   T y p e s�j   o      �i�i  0 translation61_command_format  �|  �{   	�	�	� l �T	��h�g	� r  �T	�	�	� J  �P	�	� 	�	�	� m  ��	�	� �	�	�  1	� 	�	�	� m  ��	�	� �	�	�  G O	� 	�	�	� m  ��	�	� �	�	�  2	� 	�	�	� m  ��	�	� �	�	�  S T O P	� 	�	�	� m  ��	�	� �
 
   3	� 


 m  ��

 �

  R E S U M E
 


 m  ��

 �

  4
 
	


	 m  ��

 �

  T I M E D _ G O

 


 m  ��

 �

  5
 


 m  ��

 �

  L O A D
 


 m  ��

 �

  6
 


 m  ��

 �

  S E T
 


 m  ��

 �
 
   7
 
!
"
! m  ��
#
# �
$
$  F I R E
" 
%
&
% m  ��
'
' �
(
(  8
& 
)
*
) m  ��
+
+ �
,
,  A L L _ O F F
* 
-
.
- l 	��
/�f�e
/ m  ��
0
0 �
1
1  9�f  �e  
. 
2
3
2 m  ��
4
4 �
5
5  R E S T O R E
3 
6
7
6 m  ��
8
8 �
9
9  1 0
7 
:
;
: m  ��
<
< �
=
= 
 R E S E T
; 
>
?
> m  ��
@
@ �
A
A  1 1
? 
B
C
B m  ��
D
D �
E
E  G O _ O F F
C 
F
G
F m  ��
H
H �
I
I  1 6
G 
J
K
J m  ��
L
L �
M
M  G O / J A M _ C L O C K
K 
N
O
N m  ��
P
P �
Q
Q  1 7
O 
R
S
R m  ��
T
T �
U
U  S T A N D B Y _ +
S 
V
W
V m  �
X
X �
Y
Y  1 8
W 
Z
[
Z m  
\
\ �
]
]  S T A N D B Y _ -
[ 
^
_
^ m  
`
` �
a
a  1 9
_ 
b
c
b m  

d
d �
e
e  S E Q U E N C E _ +
c 
f
g
f l 	

h�d�c
h m  

i
i �
j
j  2 0�d  �c  
g 
k
l
k m  
m
m �
n
n  S E Q U E N C E _ -
l 
o
p
o m  
q
q �
r
r  2 1
p 
s
t
s m  
u
u �
v
v  S T A R T _ C L O C K
t 
w
x
w m  
y
y �
z
z  2 2
x 
{
|
{ m  
}
} �
~
~  S T O P _ C L O C K
| 

�
 m  
�
� �
�
�  2 3
� 
�
�
� m  "
�
� �
�
�  Z E R O _ C L O C K
� 
�
�
� m  "%
�
� �
�
�  2 4
� 
�
�
� m  %(
�
� �
�
�  S E T _ C L O C K
� 
�
�
� m  (+
�
� �
�
�  2 5
� 
�
�
� m  +.
�
� �
�
�  M T C _ C H A S E _ O N
� 
�
�
� l 	.1
��b�a
� m  .1
�
� �
�
�  2 6�b  �a  
� 
�
�
� m  14
�
� �
�
�  M T C _ C H A S E _ O F F
� 
�
�
� m  47
�
� �
�
�  2 7
� 
�
�
� m  7:
�
� �
�
�  O P E N _ C U E _ L I S T
� 
�
�
� m  :=
�
� �
�
�  2 8
� 
�
�
� m  =@
�
� �
�
�  C L O S E _ C U E _ L I S T
� 
�
�
� m  @C
�
� �
�
�  2 9
� 
�
�
� m  CF
�
� �
�
�  O P E N _ C U E _ P A T H
� 
�
�
� m  FI
�
� �
�
�  3 0
� 
��`
� m  IL
�
� �
�
�  C L O S E _ C U E _ P A T H�`  	� o      �_�_  0 translation62_command_number  �h  �g  	� 
�
�
� l     �^�]�\�^  �]  �\  
� 
�
�
� l     �[
�
��[  
� * $ Customisable reporting translations   
� �
�
� H   C u s t o m i s a b l e   r e p o r t i n g   t r a n s l a t i o n s
� 
�
�
� l     �Z�Y�X�Z  �Y  �X  
� 
�
�
� l Ui
�
�
�
� r  Ui
�
�
� J  Ue
�
� 
�
�
� m  UX
�
� �
�
�  0 , 0
� 
�
�
� m  X[
�
� �
�
�  M a s t e r
� 
�
�
� m  [^
�
� �
�
�  0 ,
� 
��W
� m  ^a
�
� �
�
�  O u t p u t  �W  
� o      �V�V ,0 crosspointsinenglish crosspointsInEnglish
� * $ Replacement text for levels columns   
� �
�
� H   R e p l a c e m e n t   t e x t   f o r   l e v e l s   c o l u m n s
� 
�
�
� l j�
��U�T
� Y  j�
��S
�
��R
� k  v�
�
� 
�
�
� s  v�
�
�
� c  v
�
�
� l v{
��Q�P
� b  v{
�
�
� o  vw�O�O 0 i  
� m  wz
�
� �
�
�  , 0�Q  �P  
� m  {~�N
�N 
TEXT
� n      
�
�
�  ;  ��
� o  ��M�M ,0 crosspointsinenglish crosspointsInEnglish
� 
��L
� s  ��
�
�
� c  ��
�
�
� l ��
��K�J
� b  ��
�
�
� m  ��
�
� �
�
�  I n p u t  
� o  ���I�I 0 i  �K  �J  
� m  ���H
�H 
TEXT
� n      
�
�
�  ;  ��
� o  ���G�G ,0 crosspointsinenglish crosspointsInEnglish�L  �S 0 i  
� m  mn�F�F 
� m  nq�E�E �R  �U  �T  
�    l     �D�C�B�D  �C  �B    l �� r  �� m  ��		 �

  � o      �A�A 00 carriagereturnsinnotes carriageReturnsInNotes h b Have to remove carriage returns from notes text as they would corrupt the tab-delimited structure    � �   H a v e   t o   r e m o v e   c a r r i a g e   r e t u r n s   f r o m   n o t e s   t e x t   a s   t h e y   w o u l d   c o r r u p t   t h e   t a b - d e l i m i t e d   s t r u c t u r e  l     �@�?�>�@  �?  �>    l �� r  �� J  ��  m  �� �  [ D r a g   a �= m  �� �    c u e   h e r e . ]�=   J        o      �<�< 00 missingcuetargetprefix missingCueTargetPrefix  �;  o      �:�: 00 missingcuetargetsuffix missingCueTargetSuffix�;   H B Construct the string to return when a cue's cue target is missing    �!! �   C o n s t r u c t   t h e   s t r i n g   t o   r e t u r n   w h e n   a   c u e ' s   c u e   t a r g e t   i s   m i s s i n g "#" l ��$�9�8$ r  ��%&% J  ��'' ()( m  ��** �++  F a d e) ,-, m  ��.. �//  n   a u d i o- 010 m  ��22 �33  D e v a m p1 454 m  ��66 �77  n   a u d i o5 898 m  ��:: �;;  A n i m a t i o n9 <=< m  ��>> �??    v i d e o= @A@ m  ��BB �CC  T a r g e tA D�7D m  ��EE �FF 
   g o t o�7  & o      �6�6 60 missingcuetargetqualifier missingCueTargetQualifier�9  �8  # GHG l     �5�4�3�5  �4  �3  H IJI l ��KLMK r  ��NON J  ��PP QRQ m  ��SS �TT 4 [ D r a g   a n   a u d i o   f i l e   h e r e . ]R U�2U m  ��VV �WW 2 [ D r a g   a   v i d e o   f i l e   h e r e . ]�2  O o      �1�1 &0 invalidfiletarget invalidFileTargetL F @ The strings to return when a cue's file target has not been set   M �XX �   T h e   s t r i n g s   t o   r e t u r n   w h e n   a   c u e ' s   f i l e   t a r g e t   h a s   n o t   b e e n   s e tJ YZY l ��[\][ r  ��^_^ m  ��`` �aa  m i s s i n g   v a l u e_ o      �0�0 &0 missingfiletarget missingFileTarget\ ? 9 The string to return when a cue's file target is missing   ] �bb r   T h e   s t r i n g   t o   r e t u r n   w h e n   a   c u e ' s   f i l e   t a r g e t   i s   m i s s i n gZ cdc l �	 efge r  �	 hih J  ��jj k�/k m  ��ll �mm  t o p�/  i o      �.�. (0 layerthousandistop layerThousandIsTopf [ U The string to return if a cue's layer is 1000 (and hence displayed as "top" by QLab)   g �nn �   T h e   s t r i n g   t o   r e t u r n   i f   a   c u e ' s   l a y e r   i s   1 0 0 0   ( a n d   h e n c e   d i s p l a y e d   a s   " t o p "   b y   Q L a b )d opo l 		qrsq r  		tut m  		vv �ww  N / Au o      �-�- *0 cuelistsnotingroups cuelistsNotInGroupsr Z T The string to return when asked which group a cue is in, and that cue is a cue list   s �xx �   T h e   s t r i n g   t o   r e t u r n   w h e n   a s k e d   w h i c h   g r o u p   a   c u e   i s   i n ,   a n d   t h a t   c u e   i s   a   c u e   l i s tp yzy l 			{|}{ r  			~~ m  			�� ���  N / A o      �,�, .0 irrelevantcrosspoints irrelevantCrosspoints| x r The string to return when asked to examine crosspoints in rows beyond the number of audio input channels in a cue   } ��� �   T h e   s t r i n g   t o   r e t u r n   w h e n   a s k e d   t o   e x a m i n e   c r o s s p o i n t s   i n   r o w s   b e y o n d   t h e   n u m b e r   o f   a u d i o   i n p u t   c h a n n e l s   i n   a   c u ez ��� l 		���� r  		��� J  		�� ��� m  		�+�+��� ��*� m  		�� ���  - I N F�*  � o      �)�) 0 minusinfinity minusInfinity� ` Z If a level is returned below the first item, the second item in this list is substituted;   � ��� �   I f   a   l e v e l   i s   r e t u r n e d   b e l o w   t h e   f i r s t   i t e m ,   t h e   s e c o n d   i t e m   i n   t h i s   l i s t   i s   s u b s t i t u t e d ;� ��� l      �(���(  � ~ x NB: Excel gets confused by "-INF" in the cells unless you let the script force Excel to open every column as "text"...    � ��� �   N B :   E x c e l   g e t s   c o n f u s e d   b y   " - I N F "   i n   t h e   c e l l s   u n l e s s   y o u   l e t   t h e   s c r i p t   f o r c e   E x c e l   t o   o p e n   e v e r y   c o l u m n   a s   " t e x t " . . .  � ��� l     �'�&�%�'  �&  �%  � ��� l     �$���$  � ' ! Reporting presets (customisable)   � ��� B   R e p o r t i n g   p r e s e t s   ( c u s t o m i s a b l e )� ��� l     �#�"�!�#  �"  �!  � ��� l 		;�� �� r  		;��� J  		7�� ��� m  		!�� ��� $ I ' v e   r o l l e d   m y   o w n� ��� m  	!	$�� ��� 0 T h e   c o l u m n s   t h a t   y o u   s e e� ��� m  	$	'�� ��� 6 P r o p e r t i e s   f o r   a u d i o   &   M I D I� ��� m  	'	*�� ��� ( P r o p e r t i e s   f o r   v i d e o� ��� m  	*	-�� ��� $ A l l   t h e   p r o p e r t i e s� ��� l 		-	0���� m  	-	0�� ��� ( J u s t   t h e   b a s i c   f a c t s�  �  � ��� m  	0	3�� ��� D K e y   p r o p e r t i e s   f o r   a   l e v e l s   r e p o r t�  � o      �� $0 availablepresets availablePresets�   �  � ��� l 	<	n���� r  	<	n��� J  	<	j�� ��� m  	<	?�� ���  u n i q u e   I D� ��� m  	?	B�� ���  t y p e� ��� m  	B	E�� ���  q   n u m b e r� ��� m  	E	H�� ���  q   n a m e� ��� m  	H	K�� ���  c u e   t a r g e t� ��� m  	K	N�� ���  f i l e   t a r g e t� ��� m  	N	Q�� ���  p r e   w a i t� ��� m  	Q	T�� ���  d u r a t i o n� ��� m  	T	W�� ���  p o s t   w a i t� ��� m  	W	Z�� ���  c o n t i n u e   m o d e� ��� m  	Z	]�� ���  b r o k e n� ��� l 		]	`���� m  	]	`�� ��� 
 n o t e s�  �  � ��� m  	`	c�� ���  m o d e� ��� m  	c	f�� ���  i s   i n   g r o u p�  � o      �� 0 preset1  �  �  � � � l 	o
�� r  	o
 J  	o
  m  	o	r �  u n i q u e   I D 	
	 m  	r	u �  t y p e
  m  	u	x �  q   n u m b e r  m  	x	{ �  q   n a m e  m  	{	~ �  c u e   t a r g e t  m  	~	� �  f i l e   t a r g e t  m  	�	� �    p r e   w a i t !"! m  	�	�## �$$  d u r a t i o n" %&% m  	�	�'' �((  p o s t   w a i t& )*) m  	�	�++ �,,  c o n t i n u e   m o d e* -.- m  	�	�// �00  b r o k e n. 121 l 		�	�3��3 m  	�	�44 �55 
 n o t e s�  �  2 676 m  	�	�88 �99  m o d e7 :;: m  	�	�<< �==  i s   i n   g r o u p; >?> m  	�	�@@ �AA ( a u d i o   i n p u t   c h a n n e l s? BCB m  	�	�DD �EE 
 p a t c hC FGF m  	�	�HH �II  s t a r t   t i m eG JKJ m  	�	�LL �MM  e n d   t i m eK NON m  	�	�PP �QQ  l o o p   s t a r t   t i m eO RSR m  	�	�TT �UU  l o o p   e n d   t i m eS VWV m  	�	�XX �YY  l o o p   c o u n tW Z[Z m  	�	�\\ �]]  i n f i n i t e   l o o p[ ^_^ l 		�	�`��` m  	�	�aa �bb  g u a r a n t e e   s y n c�  �  _ cdc m  	�	�ee �ff  i n t e g r a t e d   f a d ed ghg m  	�	�ii �jj  f a d e   m o d eh klk m  	�	�mm �nn * s t o p   t a r g e t   w h e n   d o n el opo m  	�	�qq �rr  c o m m a n dp sts m  	�	�uu �vv  c h a n n e lt wxw m  	�	�yy �zz  b y t e   o n ex {|{ m  	�	�}} �~~  b y t e   t w o| � m  	�	��� ���  b y t e   c o m b o� ��� m  	�	��� ���  s t a r t   v a l u e� ��� l 		�	����� m  	�	��� ���  e n d   v a l u e�  �  � ��� m  	�	��� ���  f a d e� ��� m  	�	��� ���  S M P T E   f o r m a t� ��� m  	�	��� ���  c o m m a n d   f o r m a t� ��� m  	�	��� ���  c o m m a n d   n u m b e r� ��� m  	�	��� ���  q _ n u m b e r� ��� m  	�	��� ���  q _ l i s t� ��� m  	�	��� ���  q _ p a t h� ��� m  	�	��� ��� 
 m a c r o� ��� m  	�	��� ���  c o n t r o l   n u m b e r� ��� m  	�	��� ���  c o n t r o l   v a l u e� ��� l 		�	����� m  	�	��� ��� 
 h o u r s�  �  � ��� m  	�	��� ���  m i n u t e s� ��� m  	�	��� ���  s e c o n d s� ��� m  	�	��� ���  f r a m e s� ��� m  	�	��� ���  s u b f r a m e s� ��� m  	�
�� ��� $ s e n d   t i m e   w i t h   s e t� ��� m  

�� ���  s y s e x   m e s s a g e� ��� m  

�� ���   M I D I   d e s t i n a t i o n� ��
� m  

�� ��� " s t a r t   t i m e   o f f s e t�
   o      �	�	 0 preset2  �  �    ��� l 

����� r  

���� J  

��� ��� m  

�� ���  u n i q u e   I D� ��� m  

�� ���  t y p e� ��� m  

�� ���  q   n u m b e r� ��� m  

 �� ���  q   n a m e� ��� m  
 
#�� ���  c u e   t a r g e t� ��� m  
#
&�� ���  f i l e   t a r g e t� ��� m  
&
)�� ���  p r e   w a i t� ��� m  
)
,�� ���  d u r a t i o n� ��� m  
,
/   �  p o s t   w a i t�  m  
/
2 �  c o n t i n u e   m o d e  m  
2
5 �		  b r o k e n 

 l 	
5
8�� m  
5
8 � 
 n o t e s�  �    m  
8
; �  m o d e  m  
;
> �  i s   i n   g r o u p  m  
>
A � 
 p a t c h  m  
A
D �  s t a r t   t i m e   m  
D
G!! �""  e n d   t i m e  #$# m  
G
J%% �&&  i n f i n i t e   l o o p$ '(' m  
J
M)) �**  f a d e   m o d e( +,+ m  
M
P-- �.. * s t o p   t a r g e t   w h e n   d o n e, /0/ m  
P
S11 �22  a u t o   s t o p0 343 m  
S
V55 �66 
 l a y e r4 787 m  
V
Y99 �::  f u l l   s c r e e n8 ;<; l 	
Y
\=��= m  
Y
\>> �?? * p r e s e r v e   a s p e c t   r a t i o�  �  < @A@ m  
\
_BB �CC  o p a c i t yA DED m  
_
bFF �GG  t r a n s l a t i o n   xE HIH m  
b
eJJ �KK  t r a n s l a t i o n   yI LML m  
e
hNN �OO  r o t a t i o nM PQP m  
h
kRR �SS  s c a l e   xQ TUT m  
k
nVV �WW  s c a l e   yU XYX m  
n
qZZ �[[  s c a l e   l o c k e dY \]\ m  
q
t^^ �__   c u s t o m   r e n d e r i n g] `a` m  
t
wbb �cc  d o   o p a c i t ya ded l 	
w
zf��f m  
w
zgg �hh  d o   t r a n s l a t i o n�  �  e iji m  
z
}kk �ll  d o   r o t a t i o nj m� m m  
}
�nn �oo  d o   s c a l e�   � o      ���� 0 preset3  �  �  � pqp l 
�
�r����r r  
�
�sts o  
�
����� 20 acceptablecolumnheaders acceptableColumnHeaderst o      ���� 0 preset4  ��  ��  q uvu l 
�
�w����w r  
�
�xyx J  
�
�zz {|{ m  
�
�}} �~~  q   n u m b e r| � m  
�
��� ���  q   n a m e� ��� m  
�
��� ���  c o n t i n u e   m o d e� ��� m  
�
��� ��� 
 n o t e s� ��� m  
�
��� ���  m o d e� ���� m  
�
��� ���  i s   i n   g r o u p��  y o      ���� 0 preset5  ��  ��  v ��� l 
�
������� r  
�
���� J  
�
��� ��� m  
�
��� ���  u n i q u e   I D� ��� m  
�
��� ���  t y p e� ��� m  
�
��� ���  q   n u m b e r� ��� m  
�
��� ���  q   n a m e� ��� m  
�
��� ���  c u e   t a r g e t� ��� m  
�
��� ���  f i l e   t a r g e t� ��� m  
�
��� ���  b r o k e n� ��� m  
�
��� ��� 
 n o t e s� ��� m  
�
��� ��� ( a u d i o   i n p u t   c h a n n e l s� ���� m  
�
��� ��� 
 p a t c h��  � o      ���� 0 preset6  ��  ��  � ��� l 
�
������� r  
�
���� J  
�
��� ��� o  
�
����� 0 preset1  � ��� o  
�
����� 0 preset2  � ��� o  
�
����� 0 preset3  � ��� o  
�
����� 0 preset4  � ��� o  
�
����� 0 preset5  � ���� o  
�
����� 0 preset6  ��  � o      ���� 0 presetmapper presetMapper��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � 6 0 Level reporting dialog variables (customisable)   � ��� `   L e v e l   r e p o r t i n g   d i a l o g   v a r i a b l e s   ( c u s t o m i s a b l e )� ��� l     ��������  ��  ��  � ��� l 
�
����� r  
�
���� m  
�
��� ���  3 2� o      ���� (0 userdefaultoutputs userDefaultOutputs� P J The default number of outputs to offer to report (stereo inputs is fixed)   � ��� �   T h e   d e f a u l t   n u m b e r   o f   o u t p u t s   t o   o f f e r   t o   r e p o r t   ( s t e r e o   i n p u t s   i s   f i x e d )� ��� l 
�
����� r  
�
���� m  
�
��� ���  1� o      ���� 0 userotherrows userOtherRows� @ : The default option to offer for rows if "Other" is chosen   � ��� t   T h e   d e f a u l t   o p t i o n   t o   o f f e r   f o r   r o w s   i f   " O t h e r "   i s   c h o s e n� ��� l 
����� r  
���� m  
��� ���  1 7� o      ���� $0 userothercolumns userOtherColumns� C = The default option to offer for columns if "Other" is chosen   � ��� z   T h e   d e f a u l t   o p t i o n   t o   o f f e r   f o r   c o l u m n s   i f   " O t h e r "   i s   c h o s e n� ��� l     ��������  ��  ��  � ��� l     ������  �   General variables   � ��� $   G e n e r a l   v a r i a b l e s� ��� l     ��������  ��  ��  �    l ���� r   m  ��
�� boovfals o      ���� 0 filemade fileMade��  ��    l ���� r  	 J  ����  	 o      ���� *0 propertiestocolumns propertiesToColumns��  ��   

 l ���� r   J  ����   o      ���� "0 groupmembership groupMembership��  ��    l     ��������  ��  ��    l :g���� Q  :g l 9� k  9�  l ��������  ��  ��    l �� ��    	 Preamble     �!!    P r e a m b l e "#" l ��������  ��  ��  # $%$ r  $&'& m   (( �)) & R e v i e w   i n s t r u c t i o n s' o      ���� 0 thenavigator theNavigator% *+* W  %�,-, k  1�.. /0/ r  1d121 n  1`343 1  \`��
�� 
bhit4 l 1\5����5 I 1\��67
�� .sysodlogaskr        TEXT6 m  1488 �99 t W o u l d   y o u   l i k e   t o   r e v i e w   t h e   i n s t r u c t i o n s   f o r   t h i s   s c r i p t ?7 ��:;
�� 
appr: l 	78<����< o  78���� 0 dialogtitle dialogTitle��  ��  ; ��=>
�� 
disp= m  ;<���� > ��?@
�� 
btns? J  ?JAA BCB m  ?BDD �EE & R e v i e w   i n s t r u c t i o n sC FGF m  BEHH �II  C a n c e lG J��J m  EHKK �LL  G e t   o n   w i t h   i t��  @ ��MN
�� 
dfltM m  MPOO �PP  G e t   o n   w i t h   i tN ��Q��
�� 
cbtnQ m  SVRR �SS  C a n c e l��  ��  ��  2 o      ���� 0 thenavigator theNavigator0 TUT Z  e�VW����V = elXYX o  eh���� 0 thenavigator theNavigatorY m  hkZZ �[[ & R e v i e w   i n s t r u c t i o n sW k  o�\\ ]^] r  ot_`_ m  op��
�� boovfals` o      ���� "0 finishedreading finishedReading^ a��a W  u�bcb k  �dd efe r  �ghg m  �ii �jj 2 C o p y   h e a d e r s   t o   C l i p b o a r dh o      ���� (0 instructionbutton1 instructionButton1f klk W  �mnm k  �oo pqp r  ��rsr n  ��tut 1  ����
�� 
bhitu l ��v����v I ����wx
�� .sysodlogaskr        TEXTw b  ��yzy b  ��{|{ b  ��}~} b  ��� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� m  ���� ��� x T h i s   s c r i p t   w i l l   i n g e s t   a   t a b - d e l i m i t e d   t e x t   f i l e ,   c o p y   i t ,  � l 	�������� m  ���� ��� � a n d   t h e n   p o p u l a t e   t h e   c o p y   w i t h   a   r e p o r t   o f   t h e   c u e s   i n   t h e   c u r r e n t   w o r k s p a c e   i n   Q L a b   -   r e t u r n i n g   t h e   p r o p e r t i e s  ��  ��  � l 	�������� m  ���� ���� y o u   s p e c i f y   i n   t h e   t e x t   f i l e . 
   
 A l t e r n a t i v e l y ,   i t   a l s o   c o m e s   w i t h   a   s e t   o f   e x c i t i n g   p r e s e t s ,   t o   w h i c h   y o u   c a n   a d d   l e v e l s   r e p o r t i n g   t o   s u i t   y o u r   n e e d s   e a c h   t i m e   y o u   r u n   t h e   s c r i p t . 
   
 W h e n   i t ' s   d o n e   y o u   c a n   c h o o s e   t o   o p e n   t h e   f i l e   i n   E x c e l ,   f o r c i n g   E x c e l   t o   n o t   t r y   t o   b e   c l e v e r   a n d ,   t h e r e f o r e ,   u n h e l p f u l l y   d i s r u p t   t h e   f o r m a t t i n g .  ��  ��  � l 	�������� m  ���� ��� T h e   f i l e   y o u   g e t   o u t   a t   t h e   e n d   i s   a   U n i c o d e   t e x t   f i l e   w i t h   n o   p a r t i c u l a r   a p p l i c a t i o n   a s s o c i a t i o n ,   r e g a r d l e s s   o f   w h a t   y o u   p u t   i n  ��  ��  � l 	�������� m  ���� ���z ( t h i s   j u s t   t u r n e d   o u t   t o   b e   t h e   e a s i e s t   w a y ) . 
   
 I f   y o u   c h o o s e   t o   m a k e   y o u r   o w n   t e x t   f i l e   t h e n   t h e   f i r s t   r o w   m u s t   c o n t a i n   t h e   " c o l u m n   h e a d e r s " ,   i e :   i t   s h o u l d   d e f i n e   w h i c h   p r o p e r t i e s   y o u   a r e  ��  ��  � l 	�������� m  ���� ��� � h o p i n g   t o   g e t   f r o m   y o u r   c u e s .   U n l e s s   y o u   c u s t o m i s e   t h e   s c r i p t ,   t h e s e   c o l u m n   h e a d e r s   m u s t   e x a c t l y   m a t c h   t h e   s t r i n g s   u s e d   i n  ��  ��  � l 	�������� m  ���� ��� Q L a b ' s   A p p l e S c r i p t   d i c t i o n a r y .   F o r   a   l i s t   y o u   c a n   l o o k   a t   t h e   d i c t i o n a r y ,   s e e   t h e   " s e t   a c c e p t a b l e C o l u m n H e a d e r s "   l i n e   i n s i d e   t h i s   s c r i p t ,  ��  ��  � l 	�������� m  ���� ��� o r   p u s h   t h e   b u t t o n   b e l o w   t o   c o p y   i t   t o   t h e   C l i p b o a r d   ( a s   a   t a b - d e l i m i t e d   r o w ) .   N o t e   t h a t   t h i s   l i s t   i s   s l i g h t l y   d i f f e r e n t   f r o m   t h e   l i s t   i n   t h e  ��  ��  ~ l 	�������� m  ���� ��� � s i s t e r   s c r i p t   " M a k e   c u e s   f r o m   a   t e x t   f i l e " ,   a s   i t   i n c l u d e s   p r o p e r t i e s   t h a t   a r e   r e a d - o n l y   ( l i k e   " b r o k e n " )   -   a n d   " p u t   i n   g r o u p "  ��  ��  | l 	�������� m  ���� ���  b e c o m e s   " i s   i n   g r o u p " .   I t ' s   a l s o   w o r t h   n o t i n g   t h a t   y o u   p r o b a b l y   w o n ' t   b e   a b l e   t o   t a k e   t h e   o u t p u t   o f   t h i s   s c r i p t ,   r u n   i t   t h r o u g h  ��  ��  z l 	�������� m  ���� ���> t h a t   s c r i p t   a n d   e n d   u p   w i t h   t h e   w o r k s p a c e   a g a i n   ( Q L a b   h a s   i t s   o w n   " S a v e "   r o u t i n e   f o r   t h a t ! ) . 
   
 T h e   n e x t   p a g e   h a s   s o m e   d e t a i l s   a b o u t   l e v e l s   a n d   c u s t o m i s a t i o n . . .��  ��  x ����
�� 
appr� o  ������ 0 dialogtitle dialogTitle� ����
�� 
disp� l 
�������� m  ������ ��  ��  � ����
�� 
btns� J  ���� ��� m  ���� ���  B a c k   t o   s t a r t� ��� m  ���� ��� 2 C o p y   h e a d e r s   t o   C l i p b o a r d� ���� m  ���� ���  T o   p a g e   2   > > >��  � �����
�� 
dflt� m  ���� ���  T o   p a g e   2   > > >��  ��  ��  s o      ���� (0 instructionbutton1 instructionButton1q ���� Z  ������� = ����� o  ������ (0 instructionbutton1 instructionButton1� m  ���� ��� 2 C o p y   h e a d e r s   t o   C l i p b o a r d� n ����� I  ���������  0 totheclipboard toTheClipboard� ��� o  ���~�~ 20 acceptablecolumnheaders acceptableColumnHeaders�  ��  �  f  ��� ��� = ���� o  ��}�} (0 instructionbutton1 instructionButton1� m  �� ���  B a c k   t o   s t a r t� ��|� r  ��� m  	�{
�{ boovtrue� o      �z�z "0 finishedreading finishedReading�|  ��  ��  n > ����� o  ���y�y (0 instructionbutton1 instructionButton1� m  ���� ��� 2 C o p y   h e a d e r s   t o   C l i p b o a r dl ��x� Z  ����w�v� = ��� o  �u�u (0 instructionbutton1 instructionButton1� m  �� ���  T o   p a g e   2   > > >� k  !��� ��� r  !(��� m  !$�� ��� 2 C o p y   h e a d e r s   t o   C l i p b o a r d� o      �t�t (0 instructionbutton2 instructionButton2� ��s� W  )���� k  5��� ��� r  5~��� n  5z��� 1  vz�r
�r 
bhit� l 5v��q�p� I 5v�o��
�o .sysodlogaskr        TEXT� b  5T��� b  5P��� b  5L��� b  5H��� b  5D� � b  5@ b  5< m  58 � r S i n c e   t h e r e   a r e   c u r r e n t l y   8 3 3   p o s s i b l e   s c r i p t a b l e   l e v e l s   l 	8;�n�m m  8; �		 � f o r   t h o s e   c u e s   t h a t   t a k e   t h e m ,   i t ' s   u p   t o   y o u   w h i c h   l e v e l s   t o   r e q u e s t   i n   y o u r   f i l e .   F o r   a n y   c r o s s p o i n t   y o u   w i s h   t o   g e t ,  �n  �m   l 	<?
�l�k
 m  <? � � a d d   a   c o l u m n   h e a d e r   o f   t h e   f o r m   " r o w , c o l u m n "   a n d   t h o s e   l e v e l s   w i l l   b e   r e t u r n e d   i n   t h a t   c o l u m n .   F o r   e x a m p l e :  �l  �k    l 	@C�j�i m  @C � � c o l u m n   h e a d e r   " 0 , 0 "   s p e c i f i e s   r o w   0   c o l u m n   0   ( i e :   t h e   M a s t e r   l e v e l ) ,   " 2 , 4 2 "   w o u l d   b e   r o w   2   c o l u m n   4 2  �j  �i  � l 	DG�h�g m  DG � � ( t h e   c r o s s p o i n t   b e t w e e n   c h a n n e l   2   o f   y o u r   a u d i o   f i l e   a n d   o u t p u t   4 2 ) .   Y o u ' l l   g e t   t h e   c h o i c e   t o   t u r n   s o m e   o f   t h e s e   a b s t r a c t  �h  �g  � l 	HK�f�e m  HK �� n u m b e r s   i n t o   t e x t   w h e n   t h e   s c r i p t   r u n s   ( t r y   i t   a n d   f i n d   o u t ! ) . 
   
 S o m e   o t h e r   s u b s t i t u t i o n   t a k e s   p l a c e   w h e n   t h e   v a l u e s   a r e   r e t u r n e d ,   e g :   c a r r i a g e   r e t u r n s   i n   a   c u e ' s   " n o t e s "   a r e   r e p l a c e d   w i t h   " � " ,   s o   a s   n o t   t o  �f  �e  � l 	LO�d�c m  LO �l b r e a k   t h e   t a b - d e l i m i t i n g .   M o s t   o f   t h e   s u b s t i t u t i o n s   a r e   c u s t o m i s a b l e ,   t h o u g h . 
   
 I n   f a c t ,   t h i s   s c r i p t   i s   h i g h l y   c u s t o m i s a b l e   -   j u s t   l o o k   i n s i d e   i t   t o   f i n d   o u t   m o r e . 
   
 I n   t e r m s   o f   s p e e d ,   t h i s   s c r i p t ' s   n o t   s o   b a d :   r e p o r t i n g   1 0 0   p r o p e r t i e s / l e v e l s   f o r   1 0 0   c u e s   t a k e s   a b o u t   4   m i n u t e s   -   a n d   t h e   s p e e d   d o e s n ' t   s e e m   t o  �d  �c  � l 	PS�b�a m  PS � b g o   d o w n   t o o   m u c h   a s   t h e   n u m b e r   o f   c u e s   g o e s   u p . . .�b  �a  � �`
�` 
appr o  WX�_�_ 0 dialogtitle dialogTitle �^
�^ 
disp l 
[\ �]�\  m  [\�[�[ �]  �\   �Z!"
�Z 
btns! J  _j## $%$ m  _b&& �''  < < <   T o   p a g e   1% ()( m  be** �++ 2 C o p y   h e a d e r s   t o   C l i p b o a r d) ,�Y, m  eh-- �..  B a c k   t o   s t a r t�Y  " �X/�W
�X 
dflt/ m  mp00 �11  B a c k   t o   s t a r t�W  �q  �p  � o      �V�V (0 instructionbutton2 instructionButton2� 2�U2 Z  �345�T3 = �676 o  ��S�S (0 instructionbutton2 instructionButton27 m  ��88 �99 2 C o p y   h e a d e r s   t o   C l i p b o a r d4 n ��:;: I  ���R<�Q�R  0 totheclipboard toTheClipboard< =�P= o  ���O�O 20 acceptablecolumnheaders acceptableColumnHeaders�P  �Q  ;  f  ��5 >?> = ��@A@ o  ���N�N (0 instructionbutton2 instructionButton2A m  ��BB �CC  B a c k   t o   s t a r t? D�MD r  ��EFE m  ���L
�L boovtrueF o      �K�K "0 finishedreading finishedReading�M  �T  �U  � > -4GHG o  -0�J�J (0 instructionbutton2 instructionButton2H m  03II �JJ 2 C o p y   h e a d e r s   t o   C l i p b o a r d�s  �w  �v  �x  c = y~KLK o  y|�I�I "0 finishedreading finishedReadingL m  |}�H
�H boovtrue��  ��  ��  U M�GM l ���F�E�D�F  �E  �D  �G  - = )0NON o  ),�C�C 0 thenavigator theNavigatorO m  ,/PP �QQ  G e t   o n   w i t h   i t+ RSR l ���B�A�@�B  �A  �@  S TUT l ���?VW�?  V   Check QLab is running   W �XX ,   C h e c k   Q L a b   i s   r u n n i n gU YZY l ���>�=�<�>  �=  �<  Z [\[ O  ��]^] r  ��_`_ I ���;a�:
�; .corecnte****       ****a l ��b�9�8b 6 ��cdc 2  ���7
�7 
prcsd = ��efe 1  ���6
�6 
pnamf m  ��gg �hh  Q L a b�9  �8  �:  ` o      �5�5 0 qlabisrunning qLabIsRunning^ m  ��ii�                                                                                  sevs  alis    �  Macintosh HD               Ѳ(�H+   8�=System Events.app                                               <2���        ����  	                CoreServices    Ѳ�      ���     8�= 8�< 8�;  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  \ jkj Z  �lm�4�3l = ��non o  ���2�2 0 qlabisrunning qLabIsRunningo m  ���1�1  m k  �pp qrq I ��0st
�0 .sysodlogaskr        TEXTs m  ��uu �vv ( Q L a b   i s   n o t   r u n n i n g .t �/wx
�/ 
apprw o  ���.�. 0 dialogtitle dialogTitlex �-yz
�- 
dispy m  ���,�,  z �+{|
�+ 
btns{ J  � }} ~�*~ m  �� ���  O K�*  | �)��
�) 
dflt� m  �� ���  O K� �(��'
�( 
givu� m  	�&�& �'  r ��%� L  �$�$  �%  �4  �3  k ��� l �#�"�!�#  �"  �!  � ��� l � ���   � J D Test for a workspace (get the name & all the cues at the same time)   � ��� �   T e s t   f o r   a   w o r k s p a c e   ( g e t   t h e   n a m e   &   a l l   t h e   c u e s   a t   t h e   s a m e   t i m e )� ��� l ����  �  �  � ��� O  u��� Q   t���� k  #D�� ��� r  #1��� n  #-��� 1  )-�
� 
pnam� 4 #)��
� 
qDoc� m  '(�� � o      �� 0 workspacename workspaceName� ��� r  2D��� I 2@���
� .corecnte****       ****� n  2<��� 2 8<�
� 
aCue� 4 28��
� 
qDoc� m  67�� �  � o      �� 0 	countcues 	countCues�  � R      ���
� .ascrerr ****      � ****�  �  � k  Lt�� ��� I Lq���
� .sysodlogaskr        TEXT� m  LO�� ��� F T h e r e   i s   n o   w o r k s p a c e   o p e n   i n   Q L a b .� ���
� 
appr� o  RS�� 0 dialogtitle dialogTitle� ���
� 
disp� l 
VW��
�	� m  VW��  �
  �	  � ���
� 
btns� J  Z_�� ��� m  Z]�� ���  O K�  � ���
� 
dflt� m  be�� ���  O K� ���
� 
givu� m  hk�� �  � ��� L  rt� �   �  � m  ���                                                                                      @ alis    h  Macintosh HD               Ѳ(�H+   
��
QLab 3.app                                                      �)�֝�P        ����  	                	Downloads     Ѳ�      ֝�P     
�� 
�� �9  .Macintosh HD:Users: cmg: Downloads: QLab 3.app   
 Q L a b   3 . a p p    M a c i n t o s h   H D  Users/cmg/Downloads/QLab 3.app  /    
��  � ��� l vv��������  ��  ��  � ��� l vv������  �   Select a preset   � ���     S e l e c t   a   p r e s e t� ��� l vv��������  ��  ��  � ��� r  v���� c  v���� l v������� I v�����
�� .gtqpchltns    @   @ ns  � o  vy���� $0 availablepresets availablePresets� ����
�� 
prmp� m  |�� ��� � P l e a s e   c h o o s e   w h e t h e r   t o   i n g e s t   y o u r   o w n   f i l e ,   o r   u s e   o n e   o f   m y   p r e s e t   r e p o r t s :� ����
�� 
appr� l 	�������� o  ������ 0 dialogtitle dialogTitle��  ��  � �����
�� 
inSL� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ $0 availablepresets availablePresets��  ��  ��  � m  ����
�� 
TEXT� o      ���� 0 thepresetmenu thePresetMenu� ��� l ����������  ��  ��  � ��� Z  ��������� = ����� o  ������ 0 thepresetmenu thePresetMenu� m  ���� ��� 
 f a l s e� L  ������  ��  ��  � ��� l ����������  ��  ��  � ��� r  ����� m  ���� ���  � n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr� ��� l ����������  ��  ��  � ��� l ��������  � 2 , Grab the current time for file-naming later   � ��� X   G r a b   t h e   c u r r e n t   t i m e   f o r   f i l e - n a m i n g   l a t e r� ��� l ��������  � � z Written with help from http://www.fluther.com/disc/22258/applescript-get-and-reformat-current-date-then-insert-it-in-any/   � ��� �   W r i t t e n   w i t h   h e l p   f r o m   h t t p : / / w w w . f l u t h e r . c o m / d i s c / 2 2 2 5 8 / a p p l e s c r i p t - g e t - a n d - r e f o r m a t - c u r r e n t - d a t e - t h e n - i n s e r t - i t - i n - a n y /� ��� l ����������  ��  ��  � ��� r  �   l     ���� I     ������
�� .misccurdldt    ��� null��  ��  ��  ��   K  �� ��
�� 
year o  ������ 0 y   ��
�� 
mnth o  ������ 0 m   ��	
�� 
day  o  ������ 0 d  	 ��
��
�� 
tstr
 o  ������ 0 t  ��  �  r   c   l ���� [   [   ]   o  ���� 0 y   m  
����' ]   o  ���� 0 m   m  ���� d o  ���� 0 d  ��  ��   m  ��
�� 
TEXT o      ���� 0 
datestring 
dateString  r   + c   ' l  # ����  o   #���� 0 t  ��  ��   m  #&��
�� 
TEXT o      ���� 0 
timestring 
timeString !"! r  ,�#$# c  ,�%&% b  ,�'(' b  ,�)*) b  ,q+,+ b  ,m-.- b  ,Y/0/ b  ,U121 b  ,A343 l 	,=5����5 l ,=6����6 n  ,=787 7 /=��9:
�� 
citm9 m  57���� : m  8<���� 8 o  ,/���� 0 
datestring 
dateString��  ��  ��  ��  4 m  =@;; �<<  -2 l 	AT=����= l AT>����> n  AT?@? 7 DT��AB
�� 
citmA m  JN���� B m  OS���� @ o  AD���� 0 
datestring 
dateString��  ��  ��  ��  0 m  UXCC �DD  -. l 	YlE����E l YlF����F n  YlGHG 7 \l��IJ
�� 
citmI m  bf���� J m  gk���� H o  Y\���� 0 
datestring 
dateString��  ��  ��  ��  , m  mpKK �LL   * l 	q�M����M l q�N����N n  q�OPO 7 t���QR
�� 
citmQ m  z|���� R m  }���� P o  qt���� 0 
timestring 
timeString��  ��  ��  ��  ( l 	��S����S l ��T����T n  ��UVU 7 ����WX
�� 
citmW m  ������ X m  ������ V o  ������ 0 
timestring 
timeString��  ��  ��  ��  & m  ����
�� 
TEXT$ o      ���� 0 thetime theTime" YZY l ����������  ��  ��  Z [\[ Z  �`]^��_] = ��`a` o  ������ 0 thepresetmenu thePresetMenua n  ��bcb 4  ����d
�� 
cobjd m  ������ c o  ������ $0 availablepresets availablePresets^ k  ��ee fgf l ����������  ��  ��  g hih l ����jk��  j + % Either get the file (and copy it)...   k �ll J   E i t h e r   g e t   t h e   f i l e   ( a n d   c o p y   i t ) . . .i mnm l ����������  ��  ��  n opo r  ��qrq I ����~s
� .sysostdfalis    ��� null�~  s �}tu
�} 
prmpt m  ��vv �ww � P l e a s e   s e l e c t   a   t a b - d e l i m i t e d   t e x t   f i l e   w h i c h   c o n t a i n s   a   h e a d e r   r o w 
 f o r   t h e   p r o p e r t i e s   y o u   w i s h   t o   i n c l u d e   i n   t h e   r e p o r t :u �|xy
�| 
dflcx l ��z�{�zz I ���y{�x
�y .earsffdralis        afdr{ m  ���w
�w afdrdesk�x  �{  �z  y �v|�u
�v 
lfiv| m  ���t
�t boovfals�u  r o      �s�s 0 originalfile originalFilep }~} l ���r�q�p�r  �q  �p  ~ � Q  ������ r  ����� I ���o��n
�o .rdwrread****        ****� o  ���m�m 0 originalfile originalFile�n  � o      �l�l 0 thetext theText� R      �k�j�i
�k .ascrerr ****      � ****�j  �i  � k  ���� ��� n ����� I  ���h�g�f�h 0 exitstrategy exitStrategy�g  �f  �  f  ��� ��e� L  ���d�d  �e  � ��� O  �f��� k  �e�� ��� r  ����� n  ����� 1  ���c
�c 
extn� o  ���b�b 0 originalfile originalFile� o      �a�a 0 theextension theExtension� ��� Z  �E���`�� = ���� o  ��_�_ 0 theextension theExtension� m  �� ���  � r  ��� n  ��� 1  �^
�^ 
ppth� o  �]�] 0 originalfile originalFile� o      �\�\ 0 newpath newPath�`  � k  E�� ��� r  !��� n  ��� 1  �[
�[ 
ppth� o  �Z�Z 0 originalfile originalFile� o      �Y�Y 0 thefullpath theFullPath� ��X� r  "E��� n  "A��� 7%A�W��
�W 
ctxt� m  +-�V�V � l .@��U�T� \  .@��� \  />��� l /6��S�R� n  /6��� 1  26�Q
�Q 
leng� o  /2�P�P 0 thefullpath theFullPath�S  �R  � l 6=��O�N� n  6=��� 1  9=�M
�M 
leng� o  69�L�L 0 theextension theExtension�O  �N  � m  >?�K�K �U  �T  � o  "%�J�J 0 thefullpath theFullPath� o      �I�I 0 newpath newPath�X  � ��H� r  Fe��� b  Fa��� b  F]��� b  FY��� b  FU��� b  FQ��� b  FM��� o  FI�G�G 0 newpath newPath� m  IL�� ���    |   Q L a b   |  � o  MP�F�F 0 workspacename workspaceName� m  QT�� ��� "   |   C u e s   r e p o r t   |  � o  UX�E�E 0 thetime theTime� m  Y\�� ���  .� o  ]`�D�D 0 theextension theExtension� o      �C�C 0 newfile newFile�H  � m  �����                                                                                  sevs  alis    �  Macintosh HD               Ѳ(�H+   8�=System Events.app                                               <2���        ����  	                CoreServices    Ѳ�      ���     8�= 8�< 8�;  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  � ��� Q  g����� k  j��� ��� l jz���� s  jz��� l ju��B�A� I ju�@��
�@ .rdwropenshor       file� o  jm�?�? 0 newfile newFile� �>��=
�> 
perm� m  pq�<
�< boovtrue�=  �B  �A  � o      �;�; 0 theopenfile theOpenFile� 5 / The final output is to a (Unicode) text file,    � ��� ^   T h e   f i n a l   o u t p u t   i s   t o   a   ( U n i c o d e )   t e x t   f i l e ,  � ��� l  {{�:���:  ���regardless of what type of file is ingested; experiments suggested that this was the safest route
            as problems were encountered when trying to put the wrong kind of text into, say, a TextEdit file
            (eg: if starting with a TextEdit file, characters like "�" are tricky as writing the file out as text makes
            a file TextEdit can't read (but Excel can), whilst writing the file out as class �class utf8� makes a file Excel can't read instead)    � ���� r e g a r d l e s s   o f   w h a t   t y p e   o f   f i l e   i s   i n g e s t e d ;   e x p e r i m e n t s   s u g g e s t e d   t h a t   t h i s   w a s   t h e   s a f e s t   r o u t e 
                         a s   p r o b l e m s   w e r e   e n c o u n t e r e d   w h e n   t r y i n g   t o   p u t   t h e   w r o n g   k i n d   o f   t e x t   i n t o ,   s a y ,   a   T e x t E d i t   f i l e 
                         ( e g :   i f   s t a r t i n g   w i t h   a   T e x t E d i t   f i l e ,   c h a r a c t e r s   l i k e   " � "   a r e   t r i c k y   a s   w r i t i n g   t h e   f i l e   o u t   a s   t e x t   m a k e s 
                         a   f i l e   T e x t E d i t   c a n ' t   r e a d   ( b u t   E x c e l   c a n ) ,   w h i l s t   w r i t i n g   t h e   f i l e   o u t   a s   c l a s s   � c l a s s   u t f 8 �   m a k e s   a   f i l e   E x c e l   c a n ' t   r e a d   i n s t e a d )  � ��9� r  {���� m  {|�8
�8 boovtrue� o      �7�7 0 filemade fileMade�9  � R      �6�5�4
�6 .ascrerr ****      � ****�5  �4  � k  ���� ��� I ���3��
�3 .sysodlogaskr        TEXT� m  ���� ��� � S o m e t h i n g   w e n t   w r o n g   w h e n   t r y i n g   t o   c o p y   a n d   r e n a m e   t h e   f i l e .   I   m a y   h a v e   l e f t   a   b i t   o f   a   m e s s . . .� �2��
�2 
appr� l 	����1�0� o  ���/�/ 0 dialogtitle dialogTitle�1  �0  � �.��
�. 
disp� m  ���-�-  � �,��
�, 
btns� J  ���� ��+� m  ���� ���  O K�+  � �* �)
�* 
dflt  m  �� �  O K�)  �  r  �� o  ���(�( 0 currenttids currentTIDs n      1  ���'
�' 
txdl 1  ���&
�& 
ascr 	�%	 L  ���$�$  �%  � 
�#
 l ���"�!� �"  �!  �   �#  ��  _ k  �`  l ������  �  �    l ����   D > Or make it on the Desktop, with current time appended to name    � |   O r   m a k e   i t   o n   t h e   D e s k t o p ,   w i t h   c u r r e n t   t i m e   a p p e n d e d   t o   n a m e  l ������  �  �    r  �� b  �� b  �� b  �� b  ��  b  ��!"! b  ��#$# b  ��%&% b  ��'(' m  ��)) �**  ( l ��+��+ I ���,�
� .earsffdralis        afdr, m  ���
� afdrdesk�  �  �  & m  ��-- �..  Q L a b   |  $ o  ���� 0 workspacename workspaceName" m  ��// �00    |    o  ���� 0 dialogtitle dialogTitle m  ��11 �22    |   o  ���� 0 thetime theTime m  ��33 �44  . t x t o      �� 0 newfile newFile 565 l ������  �  �  6 787 Y  �9�:;�9 Z  �<=�
�	< = ��>?> o  ���� 0 thepresetmenu thePresetMenu? n  ��@A@ 4  ���B
� 
cobjB o  ���� 0 i  A o  ���� $0 availablepresets availablePresets= k  �CC DED r  �FGF n  �HIH 4  �J
� 
cobjJ l K��K \  LML o  �� 0 i  M m  � �  �  �  I o  ����� 0 presetmapper presetMapperG o      ���� 0 chosenpreset chosenPresetE N��N  S  ��  �
  �	  � 0 i  : m  ������ ; I ����O��
�� .corecnte****       ****O o  ������ $0 availablepresets availablePresets��  �  8 PQP l ��������  ��  ��  Q RSR l ��TU��  T   Ask about levels   U �VV "   A s k   a b o u t   l e v e l sS WXW l ��������  ��  ��  X YZY r  '[\[ b  #]^] b  _`_ m  aa �bb  S t e r e o   t o  ` o  ���� (0 userdefaultoutputs userDefaultOutputs^ m  "cc �dd    o u t p u t s\ o      ���� &0 userdefinedbutton userDefinedButtonZ efe r  (Qghg n  (Miji 1  IM��
�� 
bhitj l (Ik����k I (I��lm
�� .sysodlogaskr        TEXTl m  (+nn �oo D D o   y o u   w a n t   t o   i n c l u d e   a n y   l e v e l s ?m ��pq
�� 
apprp l 	./r����r o  ./���� 0 dialogtitle dialogTitle��  ��  q ��st
�� 
btnss J  2=uu vwv m  25xx �yy  N ow z{z o  58���� &0 userdefinedbutton userDefinedButton{ |��| m  8;}} �~~ 
 O t h e r��  t ����
�� 
dflt o  @C���� &0 userdefinedbutton userDefinedButton��  ��  ��  h o      ����  0 levelsquestion levelsQuestionf ��� Z  R������� = RY��� o  RU����  0 levelsquestion levelsQuestion� o  UX���� &0 userdefinedbutton userDefinedButton� r  \}��� J  \f�� ��� m  \]���� � ���� c  ]d��� o  ]`���� (0 userdefaultoutputs userDefaultOutputs� m  `c��
�� 
nmbr��  � J      �� ��� o      ���� 0 	totalrows 	totalRows� ���� o      ���� 0 totalcolumns totalColumns��  � ��� = ����� o  ������  0 levelsquestion levelsQuestion� m  ���� ��� 
 O t h e r� ���� k  ���� ��� r  ����� m  ���� ���  � o      ���� 0 rowsquestion rowsQuestion� ��� W  ���� k  ��� ��� r  ����� n  ����� 1  ����
�� 
ttxt� l �������� I ������
�� .sysodlogaskr        TEXT� m  ���� ��� � E n t e r   t h e   n u m b e r   o f   r o w s   y o u   w i s h   t o   r e p o r t   ( i e :   a   n u m b e r   b e t w e e n   1   &   1 7 ) :� ����
�� 
appr� l 	�������� o  ������ 0 dialogtitle dialogTitle��  ��  � ����
�� 
btns� J  ���� ���� m  ���� ���  O K��  � ����
�� 
dflt� m  ���� ���  O K� �����
�� 
dtxt� o  ������ 0 userotherrows userOtherRows��  ��  ��  � o      ���� 0 rowsquestion rowsQuestion� ���� Q  ����� k  ���� ��� r  ����� c  ����� o  ������ 0 rowsquestion rowsQuestion� m  ����
�� 
nmbr� o      ���� 0 rowsno rowsNo� ���� Z  ��������� G  ����� A ����� o  ������ 0 rowsno rowsNo� m  ������ � ? ����� o  ������ 0 rowsno rowsNo� m  ������ � r  ����� m  ���� ���  � o      ���� 0 rowsquestion rowsQuestion��  ��  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � r   ��� m   �� ���  � o      ���� 0 rowsquestion rowsQuestion��  � > ����� o  ������ 0 rowsquestion rowsQuestion� m  ���� ���  � ��� r  ��� m  �� ���  � o      ���� "0 columnsquestion columnsQuestion� ��� W  ���� k  !��� ��� r  !J��� n  !F��� 1  BF��
�� 
ttxt� l 	!B������ l !B������ I !B����
�� .sysodlogaskr        TEXT� m  !$�� ��� � E n t e r   t h e   n u m b e r   o f   c o l u m n s   y o u   w i s h   t o   r e p o r t   ( i e :   a   n u m b e r   b e t w e e n   1   &   4 9 ) :� ����
�� 
appr� l 	'(������ o  '(���� 0 dialogtitle dialogTitle��  ��  � ����
�� 
btns� J  +0�� ���� m  +.�� ���  O K��  � ��� 
�� 
dflt� m  36 �  O K  ����
�� 
dtxt o  9<���� $0 userothercolumns userOtherColumns��  ��  ��  ��  ��  � o      ���� "0 columnsquestion columnsQuestion� �� Q  K� k  N{ 	
	 r  NY c  NU o  NQ���� "0 columnsquestion columnsQuestion m  QT��
�� 
nmbr o      ���� 0 	columnsno 	columnsNo
 �� Z  Z{���� G  Zm A Z_ o  Z]���� 0 	columnsno 	columnsNo m  ]^����  ? bi o  be���� 0 	columnsno 	columnsNo m  eh���� 1 r  pw m  ps �   o      ���� "0 columnsquestion columnsQuestion��  ��  ��   R      ������
�� .ascrerr ****      � ****��  ��   r  �� m  �� �   o      ���� "0 columnsquestion columnsQuestion��  � >   !  o  ���� "0 columnsquestion columnsQuestion! m  "" �##  � $��$ r  ��%&% J  ��'' ()( \  ��*+* o  ������ 0 rowsno rowsNo+ m  ������ ) ,��, \  ��-.- o  ������ 0 	columnsno 	columnsNo. m  ������ ��  & J      // 010 o      ���� 0 	totalrows 	totalRows1 2��2 o      ���� 0 totalcolumns totalColumns��  ��  ��  ��  � 343 Z  ��56����5 > ��787 o  ������  0 levelsquestion levelsQuestion8 m  ��99 �::  N o6 Y  ��;��<=��; Y  ��>��?@��> s  ��ABA c  ��CDC l ��E���E b  ��FGF b  ��HIH o  ���~�~ 0 i  I m  ��JJ �KK  ,G o  ���}�} 0 j  ��  �  D m  ���|
�| 
TEXTB n      LML  ;  ��M o  ���{�{ 0 chosenpreset chosenPreset�� 0 j  ? m  ���z�z  @ o  ���y�y 0 totalcolumns totalColumns��  �� 0 i  < m  ���x�x  = o  ���w�w 0 	totalrows 	totalRows��  ��  ��  4 NON l ���v�u�t�v  �u  �t  O PQP r  � RSR 1  ���s
�s 
tab S n     TUT 1  ���r
�r 
txdlU 1  ���q
�q 
ascrQ VWV r  XYX c  Z[Z o  �p�p 0 chosenpreset chosenPreset[ m  �o
�o 
ctxtY o      �n�n 0 thetext theTextW \]\ r  ^_^ m  `` �aa  _ n     bcb 1  �m
�m 
txdlc 1  �l
�l 
ascr] ded Q  ^fghf k  .ii jkj s  (lml l #n�k�jn I #�iop
�i .rdwropenshor       fileo o  �h�h 0 newfile newFilep �gq�f
�g 
permq m  �e
�e boovtrue�f  �k  �j  m o      �d�d 0 theopenfile theOpenFilek r�cr r  ).sts m  )*�b
�b boovtruet o      �a�a 0 filemade fileMade�c  g R      �`�_�^
�` .ascrerr ****      � ****�_  �^  h k  6^uu vwv I 6U�]xy
�] .sysodlogaskr        TEXTx m  69zz �{{ � S o m e t h i n g   w e n t   w r o n g   w h e n   t r y i n g   t o   c r e a t e   t h a t   f i l e .   I   m a y   h a v e   l e f t   s o m e   m e s s   o n   y o u r   D e s k t o p . . .y �\|}
�\ 
appr| l 	<=~�[�Z~ o  <=�Y�Y 0 dialogtitle dialogTitle�[  �Z  } �X�
�X 
disp m  @A�W�W  � �V��
�V 
btns� J  DI�� ��U� m  DG�� ���  O K�U  � �T��S
�T 
dflt� m  LO�� ���  O K�S  w ��� r  V[��� o  VW�R�R 0 currenttids currentTIDs� n     ��� 1  XZ�Q
�Q 
txdl� 1  WX�P
�P 
ascr� ��O� L  \^�N�N  �O  e ��M� l __�L�K�J�L  �K  �J  �M  \ ��� l aa�I�H�G�I  �H  �G  � ��� l aa�F���F  � "  Set up translation matrices   � ��� 8   S e t   u p   t r a n s l a t i o n   m a t r i c e s� ��� l aa�E�D�C�E  �D  �C  � ��� r  ah��� 1  ad�B
�B 
tab � n     ��� 1  eg�A
�A 
txdl� 1  de�@
�@ 
ascr� ��� l ii�?�>�=�?  �>  �=  � ��� Q  i����� l l|���� r  l|��� n  lx��� 2  tx�<
�< 
citm� n  lt��� 4  ot�;�
�; 
cpar� m  rs�:�: � o  lo�9�9 0 thetext theText� o      �8�8 0 	headerrow 	headerRow�   Pull headers from file   � ��� .   P u l l   h e a d e r s   f r o m   f i l e� R      �7�6�5
�7 .ascrerr ****      � ****�6  �5  � k  ���� ��� n ����� I  ���4�3�2�4 0 exitstrategy exitStrategy�3  �2  �  f  ��� ��1� L  ���0�0  �1  � ��� l ���/�.�-�/  �.  �-  � ��� Y  ����,���+� l ������ k  ���� ��� s  ����� m  ���*�*  � n      ���  ;  ��� o  ���)�) *0 propertiestocolumns propertiesToColumns� ��(� Y  ����'���&� Z  �����%�$� = ����� n  ����� 4  ���#�
�# 
cobj� o  ���"�" 0 j  � o  ���!�! 0 	headerrow 	headerRow� n  ����� 4  ��� �
�  
cobj� o  ���� 0 i  � o  ���� 20 acceptablecolumnheaders acceptableColumnHeaders� r  ����� o  ���� 0 j  � n      ��� 4  ����
� 
cobj� o  ���� 0 i  � o  ���� *0 propertiestocolumns propertiesToColumns�%  �$  �' 0 j  � m  ���� � I �����
� .corecnte****       ****� o  ���� 0 	headerrow 	headerRow�  �&  �(  � K E Find which properties are in text file, and which column they are in   � ��� �   F i n d   w h i c h   p r o p e r t i e s   a r e   i n   t e x t   f i l e ,   a n d   w h i c h   c o l u m n   t h e y   a r e   i n�, 0 i  � m  ���� � I �����
� .corecnte****       ****� o  ���� 20 acceptablecolumnheaders acceptableColumnHeaders�  �+  � ��� l ������  �  �  � ��� r  ����� N  ���� o      �� *0 propertiestocolumns propertiesToColumns� o      �� 00 propertiestocolumnsref propertiesToColumnsRef� ��� l �����
�  �  �
  � ��� Y  ���	���� l ����� Z  ������ E  ���� n  ���� 4  ���
� 
cobj� o  �� 0 i  � o  ���� 0 	headerrow 	headerRow� m  �� ���  ,� s  ��� o  �� 0 i  � n      ���  ;  � o  �� 0 levelcolumns levelColumns�  �  � 3 - Make a list of all columns flagged as levels   � ��� Z   M a k e   a   l i s t   o f   a l l   c o l u m n s   f l a g g e d   a s   l e v e l s�	 0 i  � m  ��� �  � I �������
�� .corecnte****       ****� o  ������ 0 	headerrow 	headerRow��  �  �    l ��������  ��  ��    l ����   0 * Make level columns headers easier to read    � T   M a k e   l e v e l   c o l u m n s   h e a d e r s   e a s i e r   t o   r e a d  l ��������  ��  ��   	
	 Z  ����� > $ l "���� I "����
�� .corecnte****       **** o  ���� 0 levelcolumns levelColumns��  ��  ��   m  "#����   k  '�  r  'U n  'Q 1  MQ��
�� 
bhit l 'M���� I 'M��
�� .sysodlogaskr        TEXT b  '. m  '* � � N o w   t h a t   I ' v e   g o t   w h a t   I   n e e d   f r o m   t h e   h e a d e r s   f o r   l e v e l s   r e p o r t i n g ,   l 	*-���� m  *-   �!! f s h a l l   I   t r a n s l a t e   ( s o m e   o f )   t h e m   i n t o   t e x t   f o r   y o u ?��  ��   ��"#
�� 
appr" o  12���� 0 dialogtitle dialogTitle# ��$%
�� 
disp$ l 
56&����& m  56���� ��  ��  % ��'(
�� 
btns' J  9A)) *+* m  9<,, �--  N o   t h a n k s+ .��. m  <?// �00  P l e a s e   d o��  ( ��1��
�� 
dflt1 m  DG22 �33  P l e a s e   d o��  ��  ��   o      ���� 0 	inenglish 	inEnglish 4��4 Z  V�56����5 = V]787 o  VY���� 0 	inenglish 	inEnglish8 m  Y\99 �::  P l e a s e   d o6 k  `};; <=< l `l>?@> r  `lABA n  `hCDC 4  ch��E
�� 
cparE m  fg���� D o  `c���� 0 thetext theTextB o      ���� 0 dirtyheader dirtyHeader? F @ Only work on first row (in case there is more text in the file)   @ �FF �   O n l y   w o r k   o n   f i r s t   r o w   ( i n   c a s e   t h e r e   i s   m o r e   t e x t   i n   t h e   f i l e )= GHG r  m|IJI n  mxKLK 1  tx��
�� 
restL n  mtMNM 2 pt��
�� 
cparN o  mp���� 0 thetext theTextJ o      ���� 0 therest theRestH OPO r  }�QRQ n  }�STS 2 ����
�� 
citmT o  }����� 0 dirtyheader dirtyHeaderR o      ���� 0 dirtycolumns dirtyColumnsP UVU r  ��WXW J  ������  X o      ���� 0 cleancolumns cleanColumnsV YZY X  ��[��\[ Z  ��]^��_] E  ��`a` o  ������ 0 
eachcolumn 
eachColumna m  ��bb �cc  ,^ l ��defd k  ��gg hih l ��jklj r  ��mnm m  ��oo �pp  "n n     qrq 1  ����
�� 
txdlr 1  ����
�� 
ascrk M G Strip out Excel formatting: 0,0 becomes "0,0" when exported from Excel   l �ss �   S t r i p   o u t   E x c e l   f o r m a t t i n g :   0 , 0   b e c o m e s   " 0 , 0 "   w h e n   e x p o r t e d   f r o m   E x c e li tut r  ��vwv n  ��xyx 2 ����
�� 
citmy o  ������ 0 
eachcolumn 
eachColumnw o      ���� 0 
cleanstore 
cleanStoreu z{z r  ��|}| m  ��~~ �  } n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr{ ���� s  ����� l �������� c  ����� o  ������ 0 
cleanstore 
cleanStore� m  ����
�� 
TEXT��  ��  � n      ���  ;  ��� o  ������ 0 cleancolumns cleanColumns��  e "  Only work on levels columns   f ��� 8   O n l y   w o r k   o n   l e v e l s   c o l u m n s��  _ s  ����� l �������� c  ����� o  ������ 0 
eachcolumn 
eachColumn� m  ����
�� 
TEXT��  ��  � n      ���  ;  ��� o  ������ 0 cleancolumns cleanColumns�� 0 
eachcolumn 
eachColumn\ o  ������ 0 dirtycolumns dirtyColumnsZ ��� r  ����� 1  ����
�� 
tab � n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr� ��� r  ����� c  ����� o  ������ 0 cleancolumns cleanColumns� m  ����
�� 
ctxt� o      ���� 0 cleanheader cleanHeader� ��� Y  �C������� l >���� k  >�� ��� r  ��� n  ��� 4  ���
�� 
cobj� o  ���� 0 i  � o  ���� ,0 crosspointsinenglish crosspointsInEnglish� n     ��� 1  ��
�� 
txdl� 1  ��
�� 
ascr� ��� r  #��� n  ��� 2 ��
�� 
citm� o  ���� 0 cleanheader cleanHeader� o      ���� 0 englishheader englishHeader� ��� r  $2��� n  $.��� 4  '.���
�� 
cobj� l *-������ [  *-��� o  *+���� 0 i  � m  +,���� ��  ��  � o  $'���� ,0 crosspointsinenglish crosspointsInEnglish� n     ��� 1  /1��
�� 
txdl� 1  ./��
�� 
ascr� ���� r  3>��� c  3:��� o  36���� 0 englishheader englishHeader� m  69��
�� 
ctxt� o      ���� 0 cleanheader cleanHeader��  � $  Replace strings in header row   � ��� <   R e p l a c e   s t r i n g s   i n   h e a d e r   r o w�� 0 i  � m  ������ � I ������
�� .corecnte****       ****� o  ����� ,0 crosspointsinenglish crosspointsInEnglish��  � m  ���� � ���� Z  D}������ = DM��� l DK������ I DK�����
�� .corecnte****       ****� o  DG���� 0 therest theRest��  ��  ��  � m  KL����  � r  PW��� o  PS���� 0 cleanheader cleanHeader� o      ���� 0 thetext theText��  � k  Z}�� ��� r  Za��� o  Z]��
�� 
ret � n     ��� 1  ^`��
�� 
txdl� 1  ]^��
�� 
ascr� ��� l bu���� r  bu��� c  bq��� b  bm��� b  bi��� o  be���� 0 cleanheader cleanHeader� o  eh��
�� 
ret � o  il���� 0 therest theRest� m  mp��
�� 
ctxt� o      ���� 0 thetext theText� $  Stitch the file back together   � ��� <   S t i t c h   t h e   f i l e   b a c k   t o g e t h e r� ���� r  v}��� 1  vy��
�� 
tab � n     ��� 1  z|��
�� 
txdl� 1  yz��
�� 
ascr��  ��  ��  ��  ��  ��  ��  
 ��� l ����~�}�  �~  �}  � ��� l ���|���|  � &   How long is this going to take?   � ��� @   H o w   l o n g   i s   t h i s   g o i n g   t o   t a k e ?� ��� l ���{�z�y�{  �z  �y  � ��� l ������ r  ����� ]  ����� o  ���x�x 0 	countcues 	countCues� l �� �w�v  ^  �� l ���u�t I ���s�r
�s .corecnte****       **** o  ���q�q 0 	headerrow 	headerRow�r  �u  �t   m  ���p�p q�w  �v  � o      �o�o 0 fudgefactor fudgeFactor� J D Account for variable number of steps that will be run for each cue;   � � �   A c c o u n t   f o r   v a r i a b l e   n u m b e r   o f   s t e p s   t h a t   w i l l   b e   r u n   f o r   e a c h   c u e ;�  l  ���n	�n   ) # testing was done with 113 headers    	 �

 F   t e s t i n g   w a s   d o n e   w i t h   1 1 3   h e a d e r s    l ���m�m   } w ###FIXME### Current estimate based on second order polynomial interpolation of 3 sample data points (!): get more data    � �   # # # F I X M E # # #   C u r r e n t   e s t i m a t e   b a s e d   o n   s e c o n d   o r d e r   p o l y n o m i a l   i n t e r p o l a t i o n   o f   3   s a m p l e   d a t a   p o i n t s   ( ! ) :   g e t   m o r e   d a t a  r  �� [  �� [  �� m  �� ?�       ]  �� m  ���l�l  o  ���k�k 0 fudgefactor fudgeFactor ]  �� m  ���j�j   l ���i�h a  �� o  ���g�g 0 fudgefactor fudgeFactor m  ���f�f �i  �h   o      �e�e 0 theeta theETA  !  Z  �\"#�d�c" ? ��$%$ o  ���b�b 0 theeta theETA% m  ���a�a (# l �X&'(& k  �X)) *+* r  ��,-, n ��./. I  ���`0�_�` 0 	makenicet 	makeNiceT0 1�^1 o  ���]�] 0 theeta theETA�^  �_  /  f  ��- o      �\�\ 0 
timestring 
timeString+ 232 r  ��454 m  ��66 �77    s e c o n d s5 o      �[�[ "0 spuriousplurals spuriousPlurals3 898 l ���Z�Y�X�Z  �Y  �X  9 :�W: Y  �X;�V<=>; k  �S?? @A@ Z  ��BC�U�TB = ��DED o  ���S�S 0 i  E m  ���R�R C r  ��FGF m  ��HH �II    s e c o n dG o      �Q�Q "0 spuriousplurals spuriousPlurals�U  �T  A JKJ r  �CLML n  �?NON 1  ;?�P
�P 
bhitO l �;P�O�NP I �;�MQR
�M .sysodlogaskr        TEXTQ b  �STS b  �UVU l �
W�L�KW c  �
XYX b  �Z[Z b  �\]\ b  � ^_^ b  ��`a` l ��b�J�Ib c  ��cdc b  ��efe m  ��gg �hh  T h e r e   a r e  f o  ���H�H 0 	countcues 	countCuesd m  ���G
�G 
TEXT�J  �I  a m  ��ii �jj �   c u e s   i n   t h i s   w o r k s p a c e . 
   
 B a s e d   o n   c u r r e n t   t e s t s ,   t h i s   m a y   t a k e   a b o u t  _ o  ���F�F 0 
timestring 
timeString] m   kk �ll T   t o   p r o c e s s ,   p o s s i b l y   l o n g e r .   
   
 Y o u   h a v e  [ o  �E�E 0 i  Y m  	�D
�D 
TEXT�L  �K  V o  
�C�C "0 spuriousplurals spuriousPluralsT m  mm �nn &   t o   h i t   " C a n c e l " . . .R �Bop
�B 
appro o  �A�A 0 dialogtitle dialogTitlep �@qr
�@ 
dispq l 
s�?�>s m  �=�=  �?  �>  r �<tu
�< 
btnst J  %vv wxw m   yy �zz  C a n c e lx {�;{ m   #|| �}}  O K�;  u �:~
�: 
dflt~ m  (+�� ���  O K �9��
�9 
cbtn� m  .1�� ���  C a n c e l� �8��7
�8 
givu� m  45�6�6 �7  �O  �N  M o      �5�5 0 goonthen goOnThenK ��4� Z  DS���3�2� = DK��� o  DG�1�1 0 goonthen goOnThen� m  GJ�� ���  O K�  S  NO�3  �2  �4  �V 0 i  < m  ���0�0 
= m  ���/�/ > m  ���.�.���W  ' : 4 Don't waste 10s telling you it's going to take 30s!   ( ��� h   D o n ' t   w a s t e   1 0 s   t e l l i n g   y o u   i t ' s   g o i n g   t o   t a k e   3 0 s !�d  �c  ! ��� l ]]�-�,�+�-  �,  �+  � ��� l ]]�*���*  �   Now, to business   � ��� "   N o w ,   t o   b u s i n e s s� ��� l ]]�)�(�'�)  �(  �'  � ��� O  ]8{��� k  c8z�� ��� l cc�&�%�$�&  �%  �$  � ��� I ch�#�"�!
�# .miscactvnull��� ��� null�"  �!  � ��� l ii� ���   �  �  � ��� I i����
� .sysodlogaskr        TEXT� m  il�� ��� ( O n e   m o m e n t   c a l l e r . . .� ���
� 
appr� o  op�� 0 dialogtitle dialogTitle� ���
� 
disp� m  st�� � ���
� 
btns� J  w|�� ��� m  wz�� ���  O K�  � ���
� 
dflt� m  ��� ���  O K� ���
� 
givu� m  ���� �  � ��� l ������  �  �  � ��� r  ����� n  ����� 1  ���
� 
aSlt� l ������ I �����

� .misccurdldt    ��� null�  �
  �  �  � o      �	�	 0 	starttime 	startTime� ��� l ������  �  �  � ��� O  �8x��� k  �8w�� ��� l ������  �  �  � ��� l ������  � !  Deal with group membership   � ��� 6   D e a l   w i t h   g r o u p   m e m b e r s h i p� ��� l ���� ���  �   ��  � ��� Z  ��������� > ����� n  ����� 4  �����
�� 
cobj� m  ������ R� o  ������ 00 propertiestocolumnsref propertiesToColumnsRef� m  ������  � l ������ k  ���� ��� r  ����� 6 ����� 2  ����
�� 
aCue� = ����� 1  ����
�� 
qTyp� m  ���� ��� 
 G r o u p� o      ���� 0 	allgroups 	allGroups� ��� r  ����� N  ���� o      ���� 0 	allgroups 	allGroups� o      ���� 0 allgroupsref allGroupsRef� ��� X  ������� k  ���� ��� r  ����� c  ����� n  ����� 1  ����
�� 
qNam� o  ������ 0 	eachgroup 	eachGroup� m  ����
�� 
TEXT� o      ���� 0 
grouptitle 
groupTitle� ��� Z  �6������� = ���� o  ������ 0 
grouptitle 
groupTitle� m  �   �  � k  2  r   c   n  
	
	 1  
��
�� 
pnam
 o  ���� 0 	eachgroup 	eachGroup m  
��
�� 
TEXT o      ���� 0 
grouptitle 
groupTitle �� Z  2���� =  o  ���� 0 
grouptitle 
groupTitle m   �   r  . c  * b  & m    �  i d :   n   % 1  !%��
�� 
ID   o   !���� 0 	eachgroup 	eachGroup m  &)��
�� 
TEXT o      ���� 0 
grouptitle 
groupTitle��  ��  ��  ��  ��  �  r  7D n  7@ !  1  <@��
�� 
ID  ! n 7<"#" 2  8<��
�� 
aCue# o  78���� 0 	eachgroup 	eachGroup o      ���� 0 childrencues childrenCues $%$ r  EO&'& l EK(����( N  EK)) o      ���� 0 childrencues childrenCues��  ��  ' o      ���� "0 childrencuesref childrenCuesRef% *��* Y  P�+��,-��+ k  `�.. /0/ s  `m121 n  `h343 4  ch��5
�� 
cobj5 o  fg���� 0 i  4 o  `c���� "0 childrencuesref childrenCuesRef2 n      676  ;  kl7 o  hk���� "0 groupmembership groupMembership0 898 s  nv:;: o  nq���� 0 
grouptitle 
groupTitle; n      <=<  ;  tu= o  qt���� "0 groupmembership groupMembership9 >?> r  w�@A@ c  w�BCB l w�D����D \  w�EFE l w�G����G n  w�HIH 1  |���
�� 
aSltI l w|J����J I w|������
�� .misccurdldt    ��� null��  ��  ��  ��  ��  ��  F o  ������ 0 	starttime 	startTime��  ��  C m  ����
�� 
longA o      ���� 0 	timetaken 	timeTaken? K��K Z  ��LM����L F  ��NON = ��PQP `  ��RSR o  ������ 0 	timetaken 	timeTakenS m  ������ Q m  ������  O ?  ��TUT o  ������ 0 	timetaken 	timeTakenU m  ������  M l ��VWXV Z  ��YZ����Y = ��[\[ n  ��]^] 1  ����
�� 
pisf^ m  ��__�                                                                                      @ alis    h  Macintosh HD               Ѳ(�H+   
��
QLab 3.app                                                      �)�֝�P        ����  	                	Downloads     Ѳ�      ֝�P     
�� 
�� �9  .Macintosh HD:Users: cmg: Downloads: QLab 3.app   
 Q L a b   3 . a p p    M a c i n t o s h   H D  Users/cmg/Downloads/QLab 3.app  /    
��  \ m  ����
�� boovtrueZ I ����`a
�� .sysodlogaskr        TEXT` m  ��bb �cc < P r o c e s s i n g   g r o u p   m e m b e r s h i p . . .a ��de
�� 
apprd o  ������ 0 dialogtitle dialogTitlee ��fg
�� 
dispf l 
��h����h m  ������ ��  ��  g ��ij
�� 
btnsi J  ��kk lml m  ��nn �oo  C a n c e lm p��p m  ��qq �rr  O K��  j ��st
�� 
dflts m  ��uu �vv  O Kt ��wx
�� 
cbtnw m  ��yy �zz  C a n c e lx ��{��
�� 
givu{ m  ������ ��  ��  ��  W P J This bit can seem like nothing's happening, so display a dialog every 15s   X �|| �   T h i s   b i t   c a n   s e e m   l i k e   n o t h i n g ' s   h a p p e n i n g ,   s o   d i s p l a y   a   d i a l o g   e v e r y   1 5 s��  ��  ��  �� 0 i  , m  ST���� - I T[��}��
�� .corecnte****       ****} o  TW���� "0 childrencuesref childrenCuesRef��  ��  ��  �� 0 	eachgroup 	eachGroup� o  ������ 0 allgroupsref allGroupsRef� ~��~ r  ��� N  ���� o      ���� "0 groupmembership groupMembership� o      ���� (0 groupmembershipref groupMembershipRef��  � #  Don't bother unless asked to   � ��� :   D o n ' t   b o t h e r   u n l e s s   a s k e d   t o��  ��  � ��� l ����������  ��  ��  � ��� Y  �8u�������� k  8p�� ��� l ��������  ��  ��  � ��� r  ��� l ������ N  �� 4  ���
�� 
aCue� o  ���� 0 i  ��  ��  � o      ���� 0 thecue theCue� ��� l ��������  ��  ��  � ��� l ������  � 9 3 Prepare a list to hold the properties for this cue   � ��� f   P r e p a r e   a   l i s t   t o   h o l d   t h e   p r o p e r t i e s   f o r   t h i s   c u e� ��� l ��������  ��  ��  � ��� r  ��� J  ����  � o      ���� 0 theproperties theProperties� ��� l ��������  ��  ��  � ��� V  ?��� s  2:��� m  25�� ���  � n      ���  ;  89� o  58���� 0 theproperties theProperties� A "1��� l ")������ I ")�����
�� .corecnte****       ****� o  "%���� 0 theproperties theProperties��  ��  ��  � l )0����� I )0�~��}
�~ .corecnte****       ****� o  ),�|�| 0 	headerrow 	headerRow�}  ��  �  � ��� l @@�{�z�y�{  �z  �y  � ��� r  @J��� l @F��x�w� N  @F�� o      �v�v 0 theproperties theProperties�x  �w  � o      �u�u $0 thepropertiesref thePropertiesRef� ��� l KK�t�s�r�t  �s  �r  � ��� r  KZ��� c  KV��� n  KR��� 1  NR�q
�q 
qTyp� o  KN�p�p 0 thecue theCue� m  RU�o
�o 
TEXT� o      �n�n 0 thetype theType� ��� Z  [����m�l� F  [t��� = [b��� o  [^�k�k 0 thetype theType� m  ^a�� ��� 
 G r o u p� = ep��� n  el��� 1  hl�j
�j 
qGMo� o  eh�i�i 0 thecue theCue� m  lo�h
�h GRUPqGCL� k  w��� ��� l w~���� r  w~��� m  wz�� ���  C u e   L i s t� o      �g�g 0 thetype theType� a [ This is a kludge to get round the way cue lists are reported as Groups in "cue_list" mode,   � ��� �   T h i s   i s   a   k l u d g e   t o   g e t   r o u n d   t h e   w a y   c u e   l i s t s   a r e   r e p o r t e d   a s   G r o u p s   i n   " c u e _ l i s t "   m o d e ,� ��f� l  �e���e  � J D even though they have additional properties that Groups don't have    � ��� �   e v e n   t h o u g h   t h e y   h a v e   a d d i t i o n a l   p r o p e r t i e s   t h a t   G r o u p s   d o n ' t   h a v e  �f  �m  �l  � ��� l ���d�c�b�d  �c  �b  � ��� l ���a���a  � n h These if�then clauses retrieve the relevant property on each cue based on the contents of the text file   � ��� �   T h e s e   i f & t h e n   c l a u s e s   r e t r i e v e   t h e   r e l e v a n t   p r o p e r t y   o n   e a c h   c u e   b a s e d   o n   t h e   c o n t e n t s   o f   t h e   t e x t   f i l e� ��� l  ���`���`  � M G (unlike "Make cues from a text file", try clauses aren't needed here)    � ��� �   ( u n l i k e   " M a k e   c u e s   f r o m   a   t e x t   f i l e " ,   t r y   c l a u s e s   a r e n ' t   n e e d e d   h e r e )  � ��� l ���_�^�]�_  �^  �]  � ��� Z  �����\�[� > ����� n  ����� 4  ���Z�
�Z 
cobj� m  ���Y�Y � o  ���X�X 00 propertiestocolumnsref propertiesToColumnsRef� m  ���W�W  � l ������ r  ����� o  ���V�V 0 thetype theType� n      ��� 4  ���U 
�U 
cobj  l ���T�S n  �� 4  ���R
�R 
cobj m  ���Q�Q  o  ���P�P 00 propertiestocolumnsref propertiesToColumnsRef�T  �S  � o  ���O�O $0 thepropertiesref thePropertiesRef�   Report the q type   � � $   R e p o r t   t h e   q   t y p e�\  �[  �  l ���N�M�L�N  �M  �L   	 Z  ��
�K�J
 > �� n  �� 4  ���I
�I 
cobj m  ���H�H  o  ���G�G 00 propertiestocolumnsref propertiesToColumnsRef m  ���F�F   l �� k  ��  r  �� c  �� n  �� 1  ���E
�E 
pnam o  ���D�D 0 thecue theCue m  ���C
�C 
TEXT o      �B�B 0 theitem theItem �A r  �� o  ���@�@ 0 theitem theItem n       !  4  ���?"
�? 
cobj" l ��#�>�=# n  ��$%$ 4  ���<&
�< 
cobj& m  ���;�; % o  ���:�: 00 propertiestocolumnsref propertiesToColumnsRef�>  �=  ! o  ���9�9 $0 thepropertiesref thePropertiesRef�A     index2_q_number    �''     i n d e x 2 _ q _ n u m b e r�K  �J  	 ()( l ���8�7�6�8  �7  �6  ) *+* Z  �,-�5�4, > ��./. n  ��010 4  ���32
�3 
cobj2 m  ���2�2 1 o  ���1�1 00 propertiestocolumnsref propertiesToColumnsRef/ m  ���0�0  - l �3453 k  �66 787 r  ��9:9 c  ��;<; n  ��=>= 1  ���/
�/ 
qNam> o  ���.�. 0 thecue theCue< m  ���-
�- 
TEXT: o      �,�, 0 theitem theItem8 ?�+? r  �@A@ o  ��*�* 0 theitem theItemA n      BCB 4  �)D
�) 
cobjD l E�(�'E n  FGF 4  
�&H
�& 
cobjH m  �%�% G o  
�$�$ 00 propertiestocolumnsref propertiesToColumnsRef�(  �'  C o  �#�# $0 thepropertiesref thePropertiesRef�+  4   index3_q_name   5 �II    i n d e x 3 _ q _ n a m e�5  �4  + JKJ l �"�!� �"  �!  �   K LML Z  �NO��N > #PQP n  !RSR 4  !�T
� 
cobjT m   �� S o  �� 00 propertiestocolumnsref propertiesToColumnsRefQ m  !"��  O l &�UVWU k  &�XX YZY r  &5[\[ c  &1]^] n  &-_`_ 1  )-�
� 
qNot` o  &)�� 0 thecue theCue^ m  -0�
� 
TEXT\ o      �� 0 theitem theItemZ a�a Z  6�bc��b > 6=ded o  69�� 0 theitem theIteme m  9<ff �gg  m i s s i n g   v a l u ec k  @~hh iji r  @Kklk n  @Gmnm 2 CG�
� 
cparn o  @C�� 0 theitem theIteml o      �� 0 	cleantext 	cleanTextj opo r  LSqrq o  LO�� 00 carriagereturnsinnotes carriageReturnsInNotesr n     sts 1  PR�
� 
txdlt 1  OP�
� 
ascrp uvu r  T_wxw c  T[yzy o  TW�� 0 	cleantext 	cleanTextz m  WZ�

�
 
ctxtx o      �	�	 0 	noreturns 	noReturnsv {|{ r  `g}~} 1  `c�
� 
tab ~ n     � 1  df�
� 
txdl� 1  cd�
� 
ascr| ��� r  h~��� o  hk�� 0 	noreturns 	noReturns� n      ��� 4  n}��
� 
cobj� l q|���� n  q|��� 4  t{� �
�  
cobj� m  wz���� � o  qt���� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  kn���� $0 thepropertiesref thePropertiesRef�  �  �  �  V   index4_notes   W ���    i n d e x 4 _ n o t e s�  �  M ��� l ����������  ��  ��  � ��� Z  �������� F  ����� E ����� o  ������ 0 index5_cue_target  � o  ������ 0 thetype theType� > ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef� m  ������  � k  �{�� ��� r  ����� n  ����� 1  ����
�� 
qQTr� o  ������ 0 thecue theCue� o      ���� 0 theitem theItem� ��� Z  �d������ = ����� o  ������ 0 theitem theItem� m  ����
�� 
msng� Z  ������� E ����� o  ������ 60 missingcuetargetqualifier missingCueTargetQualifier� o  ������ 0 thetype theType� Y  �������� Z  ��������� = ����� o  ������ 0 thetype theType� n  ����� 4  �����
�� 
cobj� o  ������ 0 j  � o  ������ 60 missingcuetargetqualifier missingCueTargetQualifier� k  ���� ��� r  ����� b  ����� b  ����� o  ������ 00 missingcuetargetprefix missingCueTargetPrefix� n  ����� 4  �����
�� 
cobj� l �������� [  ����� o  ������ 0 j  � m  ������ ��  ��  � o  ������ 60 missingcuetargetqualifier missingCueTargetQualifier� o  ������ 00 missingcuetargetsuffix missingCueTargetSuffix� o      ���� 0 targettitle targetTitle� ����  S  ����  ��  ��  �� 0 j  � m  ������ � I �������
�� .corecnte****       ****� o  ������ 60 missingcuetargetqualifier missingCueTargetQualifier��  � m  ������ ��  � r  ��� b  ��� o  
���� 00 missingcuetargetprefix missingCueTargetPrefix� o  
���� 00 missingcuetargetsuffix missingCueTargetSuffix� o      ���� 0 targettitle targetTitle��  � k  d�� ��� r  $��� c   ��� l ������ n  ��� 1  ��
�� 
qNam� o  ���� 0 theitem theItem��  ��  � m  ��
�� 
TEXT� o      ���� 0 targettitle targetTitle� ���� Z  %d������� = %,��� o  %(���� 0 targettitle targetTitle� m  (+�� ���  � k  /`�� ��� r  />��� c  /:��� l /6������ n  /6��� 1  26��
�� 
pnam� o  /2���� 0 theitem theItem��  ��  � m  69��
�� 
TEXT� o      ���� 0 targettitle targetTitle� ���� Z  ?`������� = ?F��� o  ?B���� 0 targettitle targetTitle� m  BE�� ���  � r  I\��� c  IX��� b  IT��� m  IL�� ���  i d :  � l LS������ n  LS��� 1  OS��
�� 
ID  � o  LO���� 0 theitem theItem��  ��  � m  TW��
�� 
TEXT� o      ���� 0 targettitle targetTitle��  ��  ��  ��  ��  ��  � ���� r  e{��� o  eh���� 0 targettitle targetTitle� n      ��� 4  kz�� 
�� 
cobj  l ny���� n  ny 4  qx��
�� 
cobj m  tw����  o  nq���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  hk���� $0 thepropertiesref thePropertiesRef��  ��  ��  �  l ����������  ��  ��    Z  �0	
����	 F  �� E �� o  ������ 0 index6_file_target   o  ������ 0 thetype theType > �� n  �� 4  ����
�� 
cobj m  ������  o  ������ 00 propertiestocolumnsref propertiesToColumnsRef m  ������  
 k  �,  Q  � k  ��  r  �� c  ��  n  ��!"! 1  ����
�� 
qFTr" o  ������ 0 thecue theCue  m  ����
�� 
TEXT o      ���� 0 theitem theItem #��# Z  ��$%��&$ = ��'(' o  ������ 0 theitem theItem( m  ��)) �**  m i s s i n g   v a l u e% r  ��+,+ o  ������ &0 missingfiletarget missingFileTarget, o      ���� 0 targettitle targetTitle��  & l ��-./- r  ��010 c  ��232 l ��4����4 n  ��565 1  ����
�� 
psxp6 l ��7����7 c  ��898 o  ������ 0 theitem theItem9 m  ����
�� 
alis��  ��  ��  ��  3 m  ����
�� 
TEXT1 o      ���� 0 targettitle targetTitle.   Convert to POSIX   / �:: "   C o n v e r t   t o   P O S I X��   R      ������
�� .ascrerr ****      � ****��  ��   Y  �;��<=��; Z  �>?����> = ��@A@ o  ������ 0 thetype theTypeA n  ��BCB 4  ����D
�� 
cobjD o  ������ 0 j  C o  ������ 0 index6_file_target  ? k  �EE FGF r  �
HIH n  �JKJ 4  ��L
�� 
cobjL o  ���� 0 j  K o  ����� &0 invalidfiletarget invalidFileTargetI o      ���� 0 targettitle targetTitleG M��M  S  ��  ��  ��  �� 0 j  < m  ���� = I ���~N�}
�~ .corecnte****       ****N o  ���|�| 0 index6_file_target  �}  ��   O�{O r  ,PQP o  �z�z 0 targettitle targetTitleQ n      RSR 4  +�yT
�y 
cobjT l *U�x�wU n  *VWV 4  ")�vX
�v 
cobjX m  %(�u�u W o  "�t�t 00 propertiestocolumnsref propertiesToColumnsRef�x  �w  S o  �s�s $0 thepropertiesref thePropertiesRef�{  ��  ��   YZY l 11�r�q�p�r  �q  �p  Z [\[ Z  1s]^�o�n] > 1=_`_ n  1;aba 4  4;�mc
�m 
cobjc m  7:�l�l b o  14�k�k 00 propertiestocolumnsref propertiesToColumnsRef` m  ;<�j�j  ^ l @odefd k  @ogg hih r  @Kjkj n  @Glml 1  CG�i
�i 
qPrem o  @C�h�h 0 thecue theCuek o      �g�g 0 thetime theTimei non r  LXpqp n LTrsr I  MT�ft�e�f 0 makehhmmssss makeHHMMSSsst u�du o  MP�c�c 0 thetime theTime�d  �e  s  f  LMq o      �b�b 0 theitem theItemo v�av r  Yowxw o  Y\�`�` 0 theitem theItemx n      yzy 4  _n�_{
�_ 
cobj{ l bm|�^�]| n  bm}~} 4  el�\
�\ 
cobj m  hk�[�[ ~ o  be�Z�Z 00 propertiestocolumnsref propertiesToColumnsRef�^  �]  z o  \_�Y�Y $0 thepropertiesref thePropertiesRef�a  e   index7_pre_wait   f ���     i n d e x 7 _ p r e _ w a i t�o  �n  \ ��� l tt�X�W�V�X  �W  �V  � ��� Z  t����U�T� F  t���� E t{��� o  tw�S�S 0 index8_duration  � o  wz�R�R 0 thetype theType� > ~���� n  ~���� 4  ���Q�
�Q 
cobj� m  ���P�P � o  ~��O�O 00 propertiestocolumnsref propertiesToColumnsRef� m  ���N�N  � k  ���� ��� r  ����� n  ����� 1  ���M
�M 
qDur� o  ���L�L 0 thecue theCue� o      �K�K 0 thetime theTime� ��� r  ����� n ����� I  ���J��I�J 0 makehhmmssss makeHHMMSSss� ��H� o  ���G�G 0 thetime theTime�H  �I  �  f  ��� o      �F�F 0 theitem theItem� ��E� r  ����� o  ���D�D 0 theitem theItem� n      ��� 4  ���C�
�C 
cobj� l ����B�A� n  ����� 4  ���@�
�@ 
cobj� m  ���?�? � o  ���>�> 00 propertiestocolumnsref propertiesToColumnsRef�B  �A  � o  ���=�= $0 thepropertiesref thePropertiesRef�E  �U  �T  � ��� l ���<�;�:�<  �;  �:  � ��� Z  ����9�8� > ����� n  ����� 4  ���7�
�7 
cobj� m  ���6�6 	� o  ���5�5 00 propertiestocolumnsref propertiesToColumnsRef� m  ���4�4  � l ����� k  ��� ��� r  ����� n  ����� 1  ���3
�3 
qPos� o  ���2�2 0 thecue theCue� o      �1�1 0 thetime theTime� ��� r  ����� n ����� I  ���0��/�0 0 makehhmmssss makeHHMMSSss� ��.� o  ���-�- 0 thetime theTime�.  �/  �  f  ��� o      �,�, 0 theitem theItem� ��+� r  ���� o  ���*�* 0 theitem theItem� n      ��� 4  ��)�
�) 
cobj� l ���(�'� n  ���� 4  � �&�
�& 
cobj� m  ���%�% 	� o  ���$�$ 00 propertiestocolumnsref propertiesToColumnsRef�(  �'  � o  ���#�# $0 thepropertiesref thePropertiesRef�+  �   index9_post_wait   � ��� "   i n d e x 9 _ p o s t _ w a i t�9  �8  � ��� l �"�!� �"  �!  �   � ��� Z  ������ > ��� n  ��� 4  ��
� 
cobj� m  �� 
� o  �� 00 propertiestocolumnsref propertiesToColumnsRef� m  ��  � l ����� k  ��� ��� r  "��� n  ��� 1  �
� 
qCon� o  �� 0 thecue theCue� o      �� 0 theitem theItem� ��� Z  #������ = #*��� o  #&�� 0 theitem theItem� m  &)�
� ContNoCo� r  -H��� n  -5��� 4  05��
� 
cobj� m  34�� � o  -0�� 0 constants10_continue_mode  � n      ��� 4  8G��
� 
cobj� l ;F���� n  ;F��� 4  >E��
� 
cobj� m  AD�� 
� o  ;>�
�
 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  58�	�	 $0 thepropertiesref thePropertiesRef� ��� = KR��� o  KN�� 0 theitem theItem� m  NQ�
� ContDoCo� ��� r  Up��� n  U]   4  X]�
� 
cobj m  [\��  o  UX�� 0 constants10_continue_mode  � n       4  `o�
� 
cobj l cn�� n  cn 4  fm� 	
�  
cobj	 m  il���� 
 o  cf���� 00 propertiestocolumnsref propertiesToColumnsRef�  �   o  ]`���� $0 thepropertiesref thePropertiesRef� 

 = sz o  sv���� 0 theitem theItem m  vy��
�� ContDoFo �� r  }� n  }� 4  ����
�� 
cobj m  ������  o  }����� 0 constants10_continue_mode   n       4  ����
�� 
cobj l ������ n  �� 4  ����
�� 
cobj m  ������ 
 o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��   o  ������ $0 thepropertiesref thePropertiesRef��  �  �  �   index10_continue_mode   � � ,   i n d e x 1 0 _ c o n t i n u e _ m o d e�  �  �  l ����������  ��  ��    Z  � !����  > ��"#" n  ��$%$ 4  ����&
�� 
cobj& m  ������ % o  ������ 00 propertiestocolumnsref propertiesToColumnsRef# m  ������  ! l �	'()' k  �	** +,+ r  ��-.- n  ��/0/ 1  ����
�� 
qArm0 o  ������ 0 thecue theCue. o      ���� 0 theitem theItem, 1��1 Z  �	234��2 = ��565 o  ������ 0 theitem theItem6 m  ����
�� boovtrue3 r  ��787 n  ��9:9 4  ����;
�� 
cobj; m  ������ : o  ������ 0 constants11_armed  8 n      <=< 4  ����>
�� 
cobj> l ��?����? n  ��@A@ 4  ����B
�� 
cobjB m  ������ A o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  = o  ������ $0 thepropertiesref thePropertiesRef4 CDC = ��EFE o  ������ 0 theitem theItemF m  ����
�� boovfalsD G��G r  �HIH n  ��JKJ 4  ����L
�� 
cobjL m  ������ K o  ������ 0 constants11_armed  I n      MNM 4  ���O
�� 
cobjO l �P����P n  �QRQ 4  ���S
�� 
cobjS m  ����� R o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  N o  ������ $0 thepropertiesref thePropertiesRef��  ��  ��  (   index11_armed   ) �TT    i n d e x 1 1 _ a r m e d��  ��   UVU l ��������  ��  ��  V WXW Z  ~YZ����Y > [\[ n  ]^] 4  ��_
�� 
cobj_ m  ���� ^ o  ���� 00 propertiestocolumnsref propertiesToColumnsRef\ m  ����  Z l z`ab` k  zcc ded r  (fgf n  $hih 1   $��
�� 
qUMTi o   ���� 0 thecue theCueg o      ���� 0 theitem theIteme j��j Z  )zklm��k = )0non o  ),���� 0 theitem theItemo m  ,/��
�� YorNYyesl r  3Npqp n  3;rsr 4  6;��t
�� 
cobjt m  9:���� s o  36���� 0 constants12_midi_trigger  q n      uvu 4  >M��w
�� 
cobjw l ALx����x n  ALyzy 4  DK��{
�� 
cobj{ m  GJ���� z o  AD���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  v o  ;>���� $0 thepropertiesref thePropertiesRefm |}| = QX~~ o  QT���� 0 theitem theItem m  TW��
�� YorNNnoo} ���� r  [v��� n  [c��� 4  ^c���
�� 
cobj� m  ab���� � o  [^���� 0 constants12_midi_trigger  � n      ��� 4  fu���
�� 
cobj� l it������ n  it��� 4  ls���
�� 
cobj� m  or���� � o  il���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  cf���� $0 thepropertiesref thePropertiesRef��  ��  ��  a   index12_midi_trigger   b ��� *   i n d e x 1 2 _ m i d i _ t r i g g e r��  ��  X ��� l ��������  ��  ��  � ��� Z  �������� > ���� n  ���� 4  �����
�� 
cobj� m  ������ � o  ����� 00 propertiestocolumnsref propertiesToColumnsRef� m  ������  � l ������ k  ���� ��� r  ����� n  ����� 1  ����
�� 
qMSt� o  ������ 0 thecue theCue� o      ���� 0 theitem theItem� ���� Z  �������� = ����� o  ������ 0 theitem theItem� m  ����
�� MICONtOn� r  ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 0 constants13_midi_command  � n      ��� 4  �����
�� 
cobj� l �������� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ������ $0 thepropertiesref thePropertiesRef� ��� = ����� o  ������ 0 theitem theItem� m  ����
�� MICONtOf� ��� r  ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 0 constants13_midi_command  � n      ��� 4  �����
�� 
cobj� l �������� n  ����� 4  ����
� 
cobj� m  ���~�~ � o  ���}�} 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ���|�| $0 thepropertiesref thePropertiesRef� ��� = ����� o  ���{�{ 0 theitem theItem� m  ���z
�z MICOPrCh� ��� r  ���� n  ����� 4  ���y�
�y 
cobj� m  ���x�x � o  ���w�w 0 constants13_midi_command  � n      ��� 4  ��v�
�v 
cobj� l ��u�t� n  ��� 4  �s�
�s 
cobj� m  �r�r � o  �q�q 00 propertiestocolumnsref propertiesToColumnsRef�u  �t  � o  ���p�p $0 thepropertiesref thePropertiesRef� ��� = ��� o  �o�o 0 theitem theItem� m  �n
�n MICOCtCh� ��� r  9��� n  &��� 4  &�m�
�m 
cobj� m  "%�l�l � o  �k�k 0 constants13_midi_command  � n      ��� 4  )8�j�
�j 
cobj� l ,7��i�h� n  ,7��� 4  /6�g�
�g 
cobj� m  25�f�f � o  ,/�e�e 00 propertiestocolumnsref propertiesToColumnsRef�i  �h  � o  &)�d�d $0 thepropertiesref thePropertiesRef� ��� = <C��� o  <?�c�c 0 theitem theItem� m  ?B�b
�b MICOKyPr� ��� r  Fc��� n  FP��� 4  IP�a�
�a 
cobj� m  LO�`�` � o  FI�_�_ 0 constants13_midi_command  � n      ��� 4  Sb�^�
�^ 
cobj� l Va��]�\� n  Va��� 4  Y`�[�
�[ 
cobj� m  \_�Z�Z � o  VY�Y�Y 00 propertiestocolumnsref propertiesToColumnsRef�]  �\  � o  PS�X�X $0 thepropertiesref thePropertiesRef� ��� = fm� � o  fi�W�W 0 theitem theItem  m  il�V
�V MICOChPr� �U r  p� n  pz 4  sz�T
�T 
cobj m  vy�S�S  o  ps�R�R 0 constants13_midi_command   n       4  }��Q	
�Q 
cobj	 l ��
�P�O
 n  �� 4  ���N
�N 
cobj m  ���M�M  o  ���L�L 00 propertiestocolumnsref propertiesToColumnsRef�P  �O   o  z}�K�K $0 thepropertiesref thePropertiesRef�U  ��  ��  �   index13_midi_command   � � *   i n d e x 1 3 _ m i d i _ c o m m a n d��  ��  �  l ���J�I�H�J  �I  �H    Z  ���G�F > �� n  �� 4  ���E
�E 
cobj m  ���D�D  o  ���C�C 00 propertiestocolumnsref propertiesToColumnsRef m  ���B�B   l �� k  ��  r  �� !  c  ��"#" n  ��$%$ 1  ���A
�A 
qMB1% o  ���@�@ 0 thecue theCue# m  ���?
�? 
TEXT! o      �>�> 0 theitem theItem &�=& r  ��'(' o  ���<�< 0 theitem theItem( n      )*) 4  ���;+
�; 
cobj+ l ��,�:�9, n  ��-.- 4  ���8/
�8 
cobj/ m  ���7�7 . o  ���6�6 00 propertiestocolumnsref propertiesToColumnsRef�:  �9  * o  ���5�5 $0 thepropertiesref thePropertiesRef�=     index14_midi_byte_one    �00 ,   i n d e x 1 4 _ m i d i _ b y t e _ o n e�G  �F   121 l ���4�3�2�4  �3  �2  2 343 Z  �-56�1�05 > ��787 n  ��9:9 4  ���/;
�/ 
cobj; m  ���.�. : o  ���-�- 00 propertiestocolumnsref propertiesToColumnsRef8 m  ���,�,  6 l �)<=>< Z  �)?@�+�*? F  ��ABA > ��CDC n  ��EFE 1  ���)
�) 
qMStF o  ���(�( 0 thecue theCueD m  ���'
�' MICOPrChB > ��GHG n  ��IJI 1  ���&
�& 
qMStJ o  ���%�% 0 thecue theCueH m  ���$
�$ MICOChPr@ k  �%KK LML r  �NON c  �
PQP n  �RSR 1  �#
�# 
qMB2S o  ��"�" 0 thecue theCueQ m  	�!
�! 
TEXTO o      � �  0 theitem theItemM T�T r  %UVU o  �� 0 theitem theItemV n      WXW 4  $�Y
� 
cobjY l #Z��Z n  #[\[ 4  "�]
� 
cobj] m  !�� \ o  �� 00 propertiestocolumnsref propertiesToColumnsRef�  �  X o  �� $0 thepropertiesref thePropertiesRef�  �+  �*  =   index15_midi_byte_two   > �^^ ,   i n d e x 1 5 _ m i d i _ b y t e _ t w o�1  �0  4 _`_ l ..����  �  �  ` aba Z  .�cd��c > .:efe n  .8ghg 4  18�i
� 
cobji m  47�� h o  .1�� 00 propertiestocolumnsref propertiesToColumnsReff m  89��  d l =�jklj k  =�mm non r  =Hpqp n  =Drsr 1  @D�
� 
qUTCs o  =@�� 0 thecue theCueq o      �� 0 theitem theItemo t�
t Z  I�uvw�	u = IPxyx o  IL�� 0 theitem theItemy m  LO�
� YorNYyesv r  Snz{z n  S[|}| 4  V[�~
� 
cobj~ m  YZ�� } o  SV��  0 constants16_timecode_trigger  { n      � 4  ^m��
� 
cobj� l al���� n  al��� 4  dk� �
�  
cobj� m  gj���� � o  ad���� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  [^���� $0 thepropertiesref thePropertiesRefw ��� = qx��� o  qt���� 0 theitem theItem� m  tw��
�� YorNNnoo� ���� r  {���� n  {���� 4  ~����
�� 
cobj� m  ������ � o  {~����  0 constants16_timecode_trigger  � n      ��� 4  �����
�� 
cobj� l �������� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ������ $0 thepropertiesref thePropertiesRef��  �	  �
  k   index16_timecode_trigger   l ��� 2   i n d e x 1 6 _ t i m e c o d e _ t r i g g e r�  �  b ��� l ����������  ��  ��  � ��� Z  �������� > ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef� m  ������  � l ����� k  ��� ��� r  ����� n  ����� 1  ����
�� 
qUWC� o  ������ 0 thecue theCue� o      ���� 0 theitem theItem� ���� Z  ������� = ����� o  ������ 0 theitem theItem� m  ����
�� YorNYyes� r  ����� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ "0 constants17_wall_clock_trigger  � n      ��� 4  �����
�� 
cobj� l �������� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ������ $0 thepropertiesref thePropertiesRef� ��� = ����� o  ������ 0 theitem theItem� m  ����
�� YorNNnoo� ���� r  ���� n  ����� 4  �����
�� 
cobj� m  ������ � o  ������ "0 constants17_wall_clock_trigger  � n      ��� 4  ����
�� 
cobj� l ������� n  ���� 4  ����
�� 
cobj� m   ���� � o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  ������ $0 thepropertiesref thePropertiesRef��  ��  ��  � !  index17_wall_clock_trigger   � ��� 6   i n d e x 1 7 _ w a l l _ c l o c k _ t r i g g e r��  ��  � ��� l ��������  ��  ��  � ��� Z  I������� > ��� n  ��� 4  ���
�� 
cobj� m  ���� � o  ���� 00 propertiestocolumnsref propertiesToColumnsRef� m  ����  � l E���� k  E�� ��� r  .��� c  *��� n  &��� 1  "&��
�� 
qwcH� o  "���� 0 thecue theCue� m  &)��
�� 
TEXT� o      ���� 0 theitem theItem� ���� r  /E��� o  /2���� 0 theitem theItem� n      ��� 4  5D���
�� 
cobj� l 8C������ n  8C��� 4  ;B���
�� 
cobj� m  >A���� � o  8;���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  25���� $0 thepropertiesref thePropertiesRef��  �   index18_wall_clock_hours   � ��� 2   i n d e x 1 8 _ w a l l _ c l o c k _ h o u r s��  ��  � ��� l JJ��������  ��  ��  � ��� Z  J�������� > JV��� n  JT��� 4  MT���
�� 
cobj� m  PS���� � o  JM���� 00 propertiestocolumnsref propertiesToColumnsRef� m  TU����  � l Y�� � k  Y  r  Yh c  Yd n  Y`	 1  \`��
�� 
qwcM	 o  Y\���� 0 thecue theCue m  `c��
�� 
TEXT o      ���� 0 theitem theItem 
��
 r  i o  il���� 0 theitem theItem n       4  o~��
�� 
cobj l r}���� n  r} 4  u|��
�� 
cobj m  x{����  o  ru���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��   o  lo���� $0 thepropertiesref thePropertiesRef��  � !  index19_wall_clock_minutes     � 6   i n d e x 1 9 _ w a l l _ c l o c k _ m i n u t e s��  ��  �  l ����������  ��  ��    Z  ������ > �� n  �� 4  ����
�� 
cobj m  ������  o  ������ 00 propertiestocolumnsref propertiesToColumnsRef m  ������   l �� !"  k  ��## $%$ r  ��&'& c  ��()( n  ��*+* 1  ����
�� 
qwcS+ o  ������ 0 thecue theCue) m  ����
�� 
TEXT' o      ���� 0 theitem theItem% ,��, r  ��-.- o  ������ 0 theitem theItem. n      /0/ 4  ����1
�� 
cobj1 l ��2����2 n  ��343 4  ����5
�� 
cobj5 m  ������ 4 o  ������ 00 propertiestocolumnsref propertiesToColumnsRef��  ��  0 o  ������ $0 thepropertiesref thePropertiesRef��  ! !  index20_wall_clock_seconds   " �66 6   i n d e x 2 0 _ w a l l _ c l o c k _ s e c o n d s��  ��   787 l ����������  ��  ��  8 9:9 Z  � �;<����; F  ��=>= E ��?@? o  ������ 0 index21_mode  @ o  ������ 0 thetype theType> > ��ABA n  ��CDC 4  ���E
� 
cobjE m  ���~�~ D o  ���}�} 00 propertiestocolumnsref propertiesToColumnsRefB m  ���|�|  < k  � �FF GHG r  ��IJI n  ��KLK 1  ���{
�{ 
qGMoL o  ���z�z 0 thecue theCueJ o      �y�y 0 theitem theItemH M�xM Z  � �NOP�wN = ��QRQ o  ���v�v 0 theitem theItemR m  ���u
�u GRUPqGCLO r  � STS n  ��UVU 4  ���tW
�t 
cobjW m  ���s�s V o  ���r�r 0 constants21_mode  T n      XYX 4  � �qZ
�q 
cobjZ l � 
[�p�o[ n  � 
\]\ 4    	�n^
�n 
cobj^ m    �m�m ] o  � �l�l 00 propertiestocolumnsref propertiesToColumnsRef�p  �o  Y o  ���k�k $0 thepropertiesref thePropertiesRefP _`_ =   aba o    �j�j 0 theitem theItemb m    �i
�i GRUPqGSS` cdc r    4efe n    !ghg 4    !�hi
�h 
cobji m     �g�g h o    �f�f 0 constants21_mode  f n      jkj 4   $ 3�el
�e 
cobjl l  ' 2m�d�cm n   ' 2non 4   * 1�bp
�b 
cobjp m   - 0�a�a o o   ' *�`�` 00 propertiestocolumnsref propertiesToColumnsRef�d  �c  k o   ! $�_�_ $0 thepropertiesref thePropertiesRefd qrq =  7 >sts o   7 :�^�^ 0 theitem theItemt m   : =�]
�] GRUPqGHSr uvu r   A \wxw n   A Iyzy 4   D I�\{
�\ 
cobj{ m   G H�[�[ z o   A D�Z�Z 0 constants21_mode  x n      |}| 4   L [�Y~
�Y 
cobj~ l  O Z�X�W n   O Z��� 4   R Y�V�
�V 
cobj� m   U X�U�U � o   O R�T�T 00 propertiestocolumnsref propertiesToColumnsRef�X  �W  } o   I L�S�S $0 thepropertiesref thePropertiesRefv ��� =  _ f��� o   _ b�R�R 0 theitem theItem� m   b e�Q
�Q GRUPqGFA� ��� r   i ���� n   i s��� 4   l s�P�
�P 
cobj� m   o r�O�O � o   i l�N�N 0 constants21_mode  � n      ��� 4   v ��M�
�M 
cobj� l  y ���L�K� n   y ���� 4   | ��J�
�J 
cobj� m    ��I�I � o   y |�H�H 00 propertiestocolumnsref propertiesToColumnsRef�L  �K  � o   s v�G�G $0 thepropertiesref thePropertiesRef� ��� =  � ���� o   � ��F�F 0 theitem theItem� m   � ��E
�E GRUPqGFR� ��D� r   � ���� n   � ���� 4   � ��C�
�C 
cobj� m   � ��B�B � o   � ��A�A 0 constants21_mode  � n      ��� 4   � ��@�
�@ 
cobj� l  � ���?�>� n   � ���� 4   � ��=�
�= 
cobj� m   � ��<�< � o   � ��;�; 00 propertiestocolumnsref propertiesToColumnsRef�?  �>  � o   � ��:�: $0 thepropertiesref thePropertiesRef�D  �w  �x  ��  ��  : ��� l  � ��9�8�7�9  �8  �7  � ��� Z   �!7���6�5� F   � ���� E  � ���� o   � ��4�4 0 index22_sync_to_timecode  � o   � ��3�3 0 thetype theType� >  � ���� n   � ���� 4   � ��2�
�2 
cobj� m   � ��1�1 � o   � ��0�0 00 propertiestocolumnsref propertiesToColumnsRef� m   � ��/�/  � k   �!3�� ��� r   � ���� n   � ���� 1   � ��.
�. 
qSTC� o   � ��-�- 0 thecue theCue� o      �,�, 0 theitem theItem� ��+� Z   �!3����*� =  � ���� o   � ��)�) 0 theitem theItem� m   � ��(
�( YorNYyes� r   �!��� n   � ���� 4   � ��'�
�' 
cobj� m   � ��&�& � o   � ��%�%  0 constants22_sync_to_timecode  � n      ��� 4   �!�$�
�$ 
cobj� l  �!��#�"� n   �!��� 4   �!�!�
�! 
cobj� m  ! !� �  � o   � ��� 00 propertiestocolumnsref propertiesToColumnsRef�#  �"  � o   � ��� $0 thepropertiesref thePropertiesRef� ��� = !
!��� o  !
!�� 0 theitem theItem� m  !!�
� YorNNnoo� ��� r  !!/��� n  !!��� 4  !!��
� 
cobj� m  !!�� � o  !!��  0 constants22_sync_to_timecode  � n      ��� 4  !!.��
� 
cobj� l !"!-���� n  !"!-��� 4  !%!,��
� 
cobj� m  !(!+�� � o  !"!%�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  !!�� $0 thepropertiesref thePropertiesRef�  �*  �+  �6  �5  � ��� l !8!8����  �  �  � ��� Z  !8!������ F  !8!R��� E !8!?��� o  !8!;�� 0 index23_sync_mode  � o  !;!>�
�
 0 thetype theType� > !B!N��� n  !B!L��� 4  !E!L�	�
�	 
cobj� m  !H!K�� � o  !B!E�� 00 propertiestocolumnsref propertiesToColumnsRef� m  !L!M��  � k  !U!��� ��� r  !U!`��� n  !U!\��� 1  !X!\�
� 
qSMo� o  !U!X�� 0 thecue theCue� o      �� 0 theitem theItem� ��� Z  !a!������ = !a!h��� o  !a!d� �  0 theitem theItem� m  !d!g��
�� MTLTsynM� r  !k!���� n  !k!s��� 4  !n!s���
�� 
cobj� m  !q!r���� � o  !k!n���� 0 constants23_sync_mode  � n         4  !v!���
�� 
cobj l !y!����� n  !y!� 4  !|!���
�� 
cobj m  !!�����  o  !y!|���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��   o  !s!v���� $0 thepropertiesref thePropertiesRef�  = !�!�	
	 o  !�!����� 0 theitem theItem
 m  !�!���
�� MTLTsynL �� r  !�!� n  !�!� 4  !�!���
�� 
cobj m  !�!�����  o  !�!����� 0 constants23_sync_mode   n       4  !�!���
�� 
cobj l !�!����� n  !�!� 4  !�!���
�� 
cobj m  !�!�����  o  !�!����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��   o  !�!����� $0 thepropertiesref thePropertiesRef��  �  �  �  �  �  l !�!���������  ��  ��    Z  !�"����� F  !�!� E !�!� !  o  !�!����� 0 index24_smpte_format  ! o  !�!����� 0 thetype theType > !�!�"#" n  !�!�$%$ 4  !�!���&
�� 
cobj& m  !�!����� % o  !�!����� 00 propertiestocolumnsref propertiesToColumnsRef# m  !�!�����   k  !�"�'' ()( r  !�!�*+* n  !�!�,-, 1  !�!���
�� 
qSMP- o  !�!����� 0 thecue theCue+ o      ���� 0 theitem theItem) .��. Z  !�"�/01��/ = !�!�232 o  !�!����� 0 theitem theItem3 m  !�!���
�� SMPTtfFP0 r  !�"454 n  !�!�676 4  !�!���8
�� 
cobj8 m  !�!����� 7 o  !�!����� 0 constants24_smpte_format  5 n      9:9 4  !�"��;
�� 
cobj; l !�"<����< n  !�"=>= 4  !�"��?
�� 
cobj? m  !�"���� > o  !�!����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  : o  !�!����� $0 thepropertiesref thePropertiesRef1 @A@ = ""BCB o  ""���� 0 theitem theItemC m  ""��
�� SMPTtiFPA DED r  ""-FGF n  ""HIH 4  ""��J
�� 
cobjJ m  ""���� I o  ""���� 0 constants24_smpte_format  G n      KLK 4  "",��M
�� 
cobjM l " "+N����N n  " "+OPO 4  "#"*��Q
�� 
cobjQ m  "&")���� P o  " "#���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  L o  ""���� $0 thepropertiesref thePropertiesRefE RSR = "0"7TUT o  "0"3���� 0 theitem theItemU m  "3"6��
�� SMPTthDRS VWV r  ":"UXYX n  ":"BZ[Z 4  "="B��\
�� 
cobj\ m  "@"A���� [ o  ":"=���� 0 constants24_smpte_format  Y n      ]^] 4  "E"T��_
�� 
cobj_ l "H"S`����` n  "H"Saba 4  "K"R��c
�� 
cobjc m  "N"Q���� b o  "H"K���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  ^ o  "B"E���� $0 thepropertiesref thePropertiesRefW ded = "X"_fgf o  "X"[���� 0 theitem theItemg m  "["^��
�� SMPTthNDe h��h r  "b"iji n  "b"lklk 4  "e"l��m
�� 
cobjm m  "h"k���� l o  "b"e���� 0 constants24_smpte_format  j n      non 4  "o"~��p
�� 
cobjp l "r"}q����q n  "r"}rsr 4  "u"|��t
�� 
cobjt m  "x"{���� s o  "r"u���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  o o  "l"o���� $0 thepropertiesref thePropertiesRef��  ��  ��  ��  ��   uvu l "�"���������  ��  ��  v wxw Z  "�"�yz����y F  "�"�{|{ E "�"�}~} o  "�"�����  0 index25_mtc_sync_source_name  ~ o  "�"����� 0 thetype theType| > "�"�� n  "�"���� 4  "�"����
�� 
cobj� m  "�"����� � o  "�"����� 00 propertiestocolumnsref propertiesToColumnsRef� m  "�"�����  z k  "�"��� ��� r  "�"���� c  "�"���� n  "�"���� 1  "�"���
�� 
qMTN� o  "�"����� 0 thecue theCue� m  "�"���
�� 
TEXT� o      ���� 0 theitem theItem� ���� Z  "�"�������� > "�"���� o  "�"����� 0 theitem theItem� m  "�"��� ���  m i s s i n g   v a l u e� r  "�"���� o  "�"����� 0 theitem theItem� n      ��� 4  "�"����
�� 
cobj� l "�"������� n  "�"���� 4  "�"����
�� 
cobj� m  "�"����� � o  "�"����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  "�"����� $0 thepropertiesref thePropertiesRef��  ��  ��  ��  ��  x ��� l "�"���������  ��  ��  � ��� Z  "�#%������� F  "�"���� E "�"���� o  "�"����� 0 index26_ltc_sync_channel  � o  "�"����� 0 thetype theType� > "�"���� n  "�"���� 4  "�"����
�� 
cobj� m  "�"����� � o  "�"����� 00 propertiestocolumnsref propertiesToColumnsRef� m  "�"�����  � k  "�#!�� ��� r  "�#
��� c  "�#��� n  "�#��� 1  "�#��
�� 
qLTC� o  "�"��� 0 thecue theCue� m  ##�~
�~ 
TEXT� o      �}�} 0 theitem theItem� ��|� r  ##!��� o  ##�{�{ 0 theitem theItem� n      ��� 4  ## �z�
�z 
cobj� l ##��y�x� n  ##��� 4  ##�w�
�w 
cobj� m  ##�v�v � o  ##�u�u 00 propertiestocolumnsref propertiesToColumnsRef�y  �x  � o  ##�t�t $0 thepropertiesref thePropertiesRef�|  ��  ��  � ��� l #&#&�s�r�q�s  �r  �q  � ��� Z  #&#m���p�o� F  #&#@��� E #&#-��� o  #&#)�n�n 0 index27_patch  � o  #)#,�m�m 0 thetype theType� > #0#<��� n  #0#:��� 4  #3#:�l�
�l 
cobj� m  #6#9�k�k � o  #0#3�j�j 00 propertiestocolumnsref propertiesToColumnsRef� m  #:#;�i�i  � k  #C#i�� ��� r  #C#R��� c  #C#N��� n  #C#J��� 1  #F#J�h
�h 
qPch� o  #C#F�g�g 0 thecue theCue� m  #J#M�f
�f 
TEXT� o      �e�e 0 theitem theItem� ��d� r  #S#i��� o  #S#V�c�c 0 theitem theItem� n      ��� 4  #Y#h�b�
�b 
cobj� l #\#g��a�`� n  #\#g��� 4  #_#f�_�
�_ 
cobj� m  #b#e�^�^ � o  #\#_�]�] 00 propertiestocolumnsref propertiesToColumnsRef�a  �`  � o  #V#Y�\�\ $0 thepropertiesref thePropertiesRef�d  �p  �o  � ��� l #n#n�[�Z�Y�[  �Z  �Y  � ��� Z  #n#����X�W� F  #n#���� E #n#u��� o  #n#q�V�V 0 index28_start_time  � o  #q#t�U�U 0 thetype theType� > #x#���� n  #x#���� 4  #{#��T�
�T 
cobj� m  #~#��S�S � o  #x#{�R�R 00 propertiestocolumnsref propertiesToColumnsRef� m  #�#��Q�Q  � k  #�#��� ��� r  #�#���� n  #�#���� 1  #�#��P
�P 
qSta� o  #�#��O�O 0 thecue theCue� o      �N�N 0 thetime theTime� ��� Z  #�#����M�L� = #�#���� o  #�#��K�K 0 thetime theTime� m  #�#��J
�J 
msng� l #�#����� r  #�#�   m  #�#��I�I   o      �H�H 0 thetime theTime� = 7 ### Mac OS X 10.6.2 fix for incorrectly returned items   � � n   # # #   M a c   O S   X   1 0 . 6 . 2   f i x   f o r   i n c o r r e c t l y   r e t u r n e d   i t e m s�M  �L  �  r  #�#� n #�#� I  #�#��G	�F�G 0 makehhmmsssss makeHHMMSSsss	 
�E
 o  #�#��D�D 0 thetime theTime�E  �F    f  #�#� o      �C�C 0 theitem theItem �B r  #�#� o  #�#��A�A 0 theitem theItem n       4  #�#��@
�@ 
cobj l #�#��?�> n  #�#� 4  #�#��=
�= 
cobj m  #�#��<�<  o  #�#��;�; 00 propertiestocolumnsref propertiesToColumnsRef�?  �>   o  #�#��:�: $0 thepropertiesref thePropertiesRef�B  �X  �W  �  l #�#��9�8�7�9  �8  �7    l #�#��6�5�4�6  �5  �4    Z  #�$#�3�2 F  #�#� E #�#�  o  #�#��1�1 0 index29_end_time    o  #�#��0�0 0 thetype theType > #�#�!"! n  #�#�#$# 4  #�#��/%
�/ 
cobj% m  #�#��.�. $ o  #�#��-�- 00 propertiestocolumnsref propertiesToColumnsRef" m  #�#��,�,   k  #�$&& '(' r  #�#�)*) n  #�#�+,+ 1  #�#��+
�+ 
qEnd, o  #�#��*�* 0 thecue theCue* o      �)�) 0 thetime theTime( -.- r  #�$/0/ n #�$121 I  #�$�(3�'�( 0 makehhmmsssss makeHHMMSSsss3 4�&4 o  #�$ �%�% 0 thetime theTime�&  �'  2  f  #�#�0 o      �$�$ 0 theitem theItem. 5�#5 r  $	$676 o  $	$�"�" 0 theitem theItem7 n      898 4  $$�!:
�! 
cobj: l $$;� �; n  $$<=< 4  $$�>
� 
cobj> m  $$�� = o  $$�� 00 propertiestocolumnsref propertiesToColumnsRef�   �  9 o  $$�� $0 thepropertiesref thePropertiesRef�#  �3  �2   ?@? l  $$$$�AB�  A��
                if theType is in index30_loop_start_time and item 30 of propertiesToColumnsRef is not 0 then
                    set theTime to loop start time of theCue
                    if theTime is missing value then -- ### Mac OS X 10.6.2 fix for incorrectly returned items
                        set theTime to 0
                    end if
                    set theItem to my makeHHMMSSsss(theTime)
                    set item (item 30 of propertiesToColumnsRef) of thePropertiesRef to theItem
                end if
 
                if theType is in index31_loop_end_time and item 31 of propertiesToColumnsRef is not 0 then
                    set theTime to loop end time of theCue
                    set theItem to my makeHHMMSSsss(theTime)
                    set item (item 31 of propertiesToColumnsRef) of thePropertiesRef to theItem
                end if
 
                if theType is in index32_loop_count and item 32 of propertiesToColumnsRef is not 0 then
                    set theItem to loop count of theCue as string
                    set item (item 32 of propertiesToColumnsRef) of thePropertiesRef to theItem
                end if
    B �CC	$ 
                                 i f   t h e T y p e   i s   i n   i n d e x 3 0 _ l o o p _ s t a r t _ t i m e   a n d   i t e m   3 0   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e T i m e   t o   l o o p   s t a r t   t i m e   o f   t h e C u e 
                                         i f   t h e T i m e   i s   m i s s i n g   v a l u e   t h e n   - -   # # #   M a c   O S   X   1 0 . 6 . 2   f i x   f o r   i n c o r r e c t l y   r e t u r n e d   i t e m s 
                                                 s e t   t h e T i m e   t o   0 
                                         e n d   i f 
                                         s e t   t h e I t e m   t o   m y   m a k e H H M M S S s s s ( t h e T i m e ) 
                                         s e t   i t e m   ( i t e m   3 0   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   t h e I t e m 
                                 e n d   i f 
   
                                 i f   t h e T y p e   i s   i n   i n d e x 3 1 _ l o o p _ e n d _ t i m e   a n d   i t e m   3 1   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e T i m e   t o   l o o p   e n d   t i m e   o f   t h e C u e 
                                         s e t   t h e I t e m   t o   m y   m a k e H H M M S S s s s ( t h e T i m e ) 
                                         s e t   i t e m   ( i t e m   3 1   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   t h e I t e m 
                                 e n d   i f 
   
                                 i f   t h e T y p e   i s   i n   i n d e x 3 2 _ l o o p _ c o u n t   a n d   i t e m   3 2   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e I t e m   t o   l o o p   c o u n t   o f   t h e C u e   a s   s t r i n g 
                                         s e t   i t e m   ( i t e m   3 2   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   t h e I t e m 
                                 e n d   i f 
  @ DED Z  $$$�FG��F F  $$$>HIH E $$$+JKJ o  $$$'�� 0 index33_infinite_loop  K o  $'$*�� 0 thetype theTypeI > $.$:LML n  $.$8NON 4  $1$8�P
� 
cobjP m  $4$7�� !O o  $.$1�� 00 propertiestocolumnsref propertiesToColumnsRefM m  $8$9��  G k  $A$�QQ RSR r  $A$LTUT n  $A$HVWV 1  $D$H�
� 
qInfW o  $A$D�� 0 thecue theCueU o      �� 0 theitem theItemS X�X Z  $M$�YZ[�Y = $M$R\]\ o  $M$P�� 0 theitem theItem] m  $P$Q�
� boovtrueZ r  $U$p^_^ n  $U$]`a` 4  $X$]�
b
�
 
cobjb m  $[$\�	�	 a o  $U$X�� 0 constants33_infinite_loop  _ n      cdc 4  $`$o�e
� 
cobje l $c$nf��f n  $c$nghg 4  $f$m�i
� 
cobji m  $i$l�� !h o  $c$f�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  d o  $]$`�� $0 thepropertiesref thePropertiesRef[ jkj = $s$xlml o  $s$v� �  0 theitem theItemm m  $v$w��
�� boovfalsk n��n r  ${$�opo n  ${$�qrq 4  $~$���s
�� 
cobjs m  $�$����� r o  ${$~���� 0 constants33_infinite_loop  p n      tut 4  $�$���v
�� 
cobjv l $�$�w����w n  $�$�xyx 4  $�$���z
�� 
cobjz m  $�$����� !y o  $�$����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  u o  $�$����� $0 thepropertiesref thePropertiesRef��  �  �  �  �  E {|{ l  $�$���}~��  }B<
                if theType is in index34_guarantee_sync and item 34 of propertiesToColumnsRef is not 0 then
                    set theItem to guarantee sync of theCue
                    if theItem is true then
                        set item (item 34 of propertiesToColumnsRef) of thePropertiesRef to item 1 of constants34_guarantee_sync
                    else if theItem is false then
                        set item (item 34 of propertiesToColumnsRef) of thePropertiesRef to item 2 of constants34_guarantee_sync
                    end if
                end if
    ~ �x 
                                 i f   t h e T y p e   i s   i n   i n d e x 3 4 _ g u a r a n t e e _ s y n c   a n d   i t e m   3 4   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e I t e m   t o   g u a r a n t e e   s y n c   o f   t h e C u e 
                                         i f   t h e I t e m   i s   t r u e   t h e n 
                                                 s e t   i t e m   ( i t e m   3 4   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   1   o f   c o n s t a n t s 3 4 _ g u a r a n t e e _ s y n c 
                                         e l s e   i f   t h e I t e m   i s   f a l s e   t h e n 
                                                 s e t   i t e m   ( i t e m   3 4   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   2   o f   c o n s t a n t s 3 4 _ g u a r a n t e e _ s y n c 
                                         e n d   i f 
                                 e n d   i f 
  | ��� Z  $�%������� F  $�$���� E $�$���� o  $�$����� 0 index35_integrated_fade  � o  $�$����� 0 thetype theType� > $�$���� n  $�$���� 4  $�$����
�� 
cobj� m  $�$����� #� o  $�$����� 00 propertiestocolumnsref propertiesToColumnsRef� m  $�$�����  � k  $�%�� ��� r  $�$���� n  $�$���� 1  $�$���
�� 
qIFa� o  $�$����� 0 thecue theCue� o      ���� 0 theitem theItem� ���� Z  $�%������ = $�$���� o  $�$����� 0 theitem theItem� m  $�$���
�� YorNYyes� r  $�$���� n  $�$���� 4  $�$����
�� 
cobj� m  $�$����� � o  $�$����� 0 constants35_integrated_fade  � n      ��� 4  $�$����
�� 
cobj� l $�$������� n  $�$���� 4  $�$����
�� 
cobj� m  $�$����� #� o  $�$����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  $�$����� $0 thepropertiesref thePropertiesRef� ��� = $�$���� o  $�$����� 0 theitem theItem� m  $�$���
�� YorNNnoo� ���� r  $�%��� n  $�%��� 4  $�%���
�� 
cobj� m  % %���� � o  $�$����� 0 constants35_integrated_fade  � n      ��� 4  %%���
�� 
cobj� l %%������ n  %%��� 4  %%���
�� 
cobj� m  %%���� #� o  %%���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  %%���� $0 thepropertiesref thePropertiesRef��  ��  ��  ��  ��  � ��� l %%��������  ��  ��  � ��� Z  %%�������� F  %%8��� E %%%��� o  %%!���� 0 index36_fade_mode  � o  %!%$���� 0 thetype theType� > %(%4��� n  %(%2��� 4  %+%2���
�� 
cobj� m  %.%1���� $� o  %(%+���� 00 propertiestocolumnsref propertiesToColumnsRef� m  %2%3����  � k  %;%��� ��� r  %;%F��� n  %;%B��� 1  %>%B��
�� 
qAbs� o  %;%>���� 0 thecue theCue� o      ���� 0 theitem theItem� ���� Z  %G%������� = %G%N��� o  %G%J���� 0 theitem theItem� m  %J%M��
�� ABREABSO� r  %Q%l��� n  %Q%Y��� 4  %T%Y���
�� 
cobj� m  %W%X���� � o  %Q%T���� 0 constants36_fade_mode  � n      ��� 4  %\%k���
�� 
cobj� l %_%j������ n  %_%j��� 4  %b%i���
�� 
cobj� m  %e%h���� $� o  %_%b���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  %Y%\���� $0 thepropertiesref thePropertiesRef� ��� = %o%v��� o  %o%r���� 0 theitem theItem� m  %r%u��
�� ABRERELA� ���� r  %y%���� n  %y%���� 4  %|%����
�� 
cobj� m  %%����� � o  %y%|���� 0 constants36_fade_mode  � n      ��� 4  %�%����
�� 
cobj� l %�%������� n  %�%���� 4  %�%����
�� 
cobj� m  %�%����� $� o  %�%����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  %�%����� $0 thepropertiesref thePropertiesRef��  ��  ��  ��  ��  � ��� l %�%���������  ��  ��  � ��� Z  %�&������� F  %�%���� E %�%���� o  %�%����� !0 index37_stop_target_when_done  � o  %�%����� 0 thetype theType� > %�%���� n  %�%���� 4  %�%����
�� 
cobj� m  %�%����� %� o  %�%����� 00 propertiestocolumnsref propertiesToColumnsRef� m  %�%�����  � k  %�&��    r  %�%� n  %�%� 1  %�%���
�� 
qAuS o  %�%����� 0 thecue theCue o      ���� 0 theitem theItem �� Z  %�&	�� = %�%�

 o  %�%����� 0 theitem theItem m  %�%���
�� boovtrue r  %�%� n  %�%� 4  %�%���
�� 
cobj m  %�%�����  o  %�%��� %0 !constants37_stop_target_when_done   n       4  %�%��
� 
cobj l %�%��� n  %�%� 4  %�%��
� 
cobj m  %�%��� % o  %�%��� 00 propertiestocolumnsref propertiesToColumnsRef�  �   o  %�%��� $0 thepropertiesref thePropertiesRef	  = %�%� o  %�%��� 0 theitem theItem m  %�%��
� boovfals � r  %�& n  %�%�  4  %�%��!
� 
cobj! m  %�%���   o  %�%��� %0 !constants37_stop_target_when_done   n      "#" 4  %�&�$
� 
cobj$ l &&%��% n  &&&'& 4  &&�~(
�~ 
cobj( m  &&�}�} %' o  &&�|�| 00 propertiestocolumnsref propertiesToColumnsRef�  �  # o  %�%��{�{ $0 thepropertiesref thePropertiesRef�  ��  ��  ��  ��  � )*) l  &&�z+,�z  +.(
                if theType is in index38_auto_stop and item 38 of propertiesToColumnsRef is not 0 then
                    set theItem to auto stop of theCue
                    if theItem is true then
                        set item (item 38 of propertiesToColumnsRef) of thePropertiesRef to item 1 of constants38_auto_stop
                    else if theItem is false then
                        set item (item 38 of propertiesToColumnsRef) of thePropertiesRef to item 2 of constants38_auto_stop
                    end if
                end if
    , �--P 
                                 i f   t h e T y p e   i s   i n   i n d e x 3 8 _ a u t o _ s t o p   a n d   i t e m   3 8   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e I t e m   t o   a u t o   s t o p   o f   t h e C u e 
                                         i f   t h e I t e m   i s   t r u e   t h e n 
                                                 s e t   i t e m   ( i t e m   3 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   1   o f   c o n s t a n t s 3 8 _ a u t o _ s t o p 
                                         e l s e   i f   t h e I t e m   i s   f a l s e   t h e n 
                                                 s e t   i t e m   ( i t e m   3 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   2   o f   c o n s t a n t s 3 8 _ a u t o _ s t o p 
                                         e n d   i f 
                                 e n d   i f 
  * ./. Z  &&u01�y�x0 F  &&2232 E &&454 o  &&�w�w 0 index39_layer  5 o  &&�v�v 0 thetype theType3 > &"&.676 n  &"&,898 4  &%&,�u:
�u 
cobj: m  &(&+�t�t '9 o  &"&%�s�s 00 propertiestocolumnsref propertiesToColumnsRef7 m  &,&-�r�r  1 k  &5&q;; <=< r  &5&D>?> c  &5&@@A@ n  &5&<BCB 1  &8&<�q
�q 
qLayC o  &5&8�p�p 0 thecue theCueA m  &<&?�o
�o 
TEXT? o      �n�n 0 theitem theItem= DED Z  &E&ZFG�m�lF = &E&LHIH o  &E&H�k�k 0 theitem theItemI m  &H&KJJ �KK  1 0 0 0G r  &O&VLML o  &O&R�j�j (0 layerthousandistop layerThousandIsTopM o      �i�i 0 theitem theItem�m  �l  E N�hN r  &[&qOPO o  &[&^�g�g 0 theitem theItemP n      QRQ 4  &a&p�fS
�f 
cobjS l &d&oT�e�dT n  &d&oUVU 4  &g&n�cW
�c 
cobjW m  &j&m�b�b 'V o  &d&g�a�a 00 propertiestocolumnsref propertiesToColumnsRef�e  �d  R o  &^&a�`�` $0 thepropertiesref thePropertiesRef�h  �y  �x  / XYX l &v&v�_�^�]�_  �^  �]  Y Z[Z Z  &v&�\]�\�[\ F  &v&�^_^ E &v&}`a` o  &v&y�Z�Z 0 index40_full_screen  a o  &y&|�Y�Y 0 thetype theType_ > &�&�bcb n  &�&�ded 4  &�&��Xf
�X 
cobjf m  &�&��W�W (e o  &�&��V�V 00 propertiestocolumnsref propertiesToColumnsRefc m  &�&��U�U  ] k  &�&�gg hih r  &�&�jkj n  &�&�lml 1  &�&��T
�T 
qFScm o  &�&��S�S 0 thecue theCuek o      �R�R 0 theitem theItemi n�Qn Z  &�&�opq�Po = &�&�rsr o  &�&��O�O 0 theitem theItems m  &�&��N
�N boovtruep r  &�&�tut n  &�&�vwv 4  &�&��Mx
�M 
cobjx m  &�&��L�L w o  &�&��K�K 0 constants40_full_screen  u n      yzy 4  &�&��J{
�J 
cobj{ l &�&�|�I�H| n  &�&�}~} 4  &�&��G
�G 
cobj m  &�&��F�F (~ o  &�&��E�E 00 propertiestocolumnsref propertiesToColumnsRef�I  �H  z o  &�&��D�D $0 thepropertiesref thePropertiesRefq ��� = &�&���� o  &�&��C�C 0 theitem theItem� m  &�&��B
�B boovfals� ��A� r  &�&���� n  &�&���� 4  &�&��@�
�@ 
cobj� m  &�&��?�? � o  &�&��>�> 0 constants40_full_screen  � n      ��� 4  &�&��=�
�= 
cobj� l &�&���<�;� n  &�&���� 4  &�&��:�
�: 
cobj� m  &�&��9�9 (� o  &�&��8�8 00 propertiestocolumnsref propertiesToColumnsRef�<  �;  � o  &�&��7�7 $0 thepropertiesref thePropertiesRef�A  �P  �Q  �\  �[  [ ��� l &�&��6�5�4�6  �5  �4  � ��� Z  &�'k���3�2� F  &�'��� E &�&���� o  &�&��1�1 !0 index41_preserve_aspect_ratio  � o  &�&��0�0 0 thetype theType� > &�'��� n  &�'��� 4  &�'�/�
�/ 
cobj� m  ''�.�. )� o  &�&��-�- 00 propertiestocolumnsref propertiesToColumnsRef� m  ''�,�,  � k  ''g�� ��� r  ''��� n  ''��� 1  ''�+
�+ 
qPAs� o  ''�*�* 0 thecue theCue� o      �)�) 0 theitem theItem� ��(� Z  ''g����'� = ''��� o  ''�&�& 0 theitem theItem� m  ''�%
�% boovtrue� r  '"'=��� n  '"'*��� 4  '%'*�$�
�$ 
cobj� m  '(')�#�# � o  '"'%�"�" %0 !constants41_preserve_aspect_ratio  � n      ��� 4  '-'<�!�
�! 
cobj� l '0';�� �� n  '0';��� 4  '3':��
� 
cobj� m  '6'9�� )� o  '0'3�� 00 propertiestocolumnsref propertiesToColumnsRef�   �  � o  '*'-�� $0 thepropertiesref thePropertiesRef� ��� = '@'E��� o  '@'C�� 0 theitem theItem� m  'C'D�
� boovfals� ��� r  'H'c��� n  'H'P��� 4  'K'P��
� 
cobj� m  'N'O�� � o  'H'K�� %0 !constants41_preserve_aspect_ratio  � n      ��� 4  'S'b��
� 
cobj� l 'V'a���� n  'V'a��� 4  'Y'`��
� 
cobj� m  '\'_�� )� o  'V'Y�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  'P'S�� $0 thepropertiesref thePropertiesRef�  �'  �(  �3  �2  � ��� l 'l'l����  �  �  � ��� Z  'l'����
�	� F  'l'���� E 'l's��� o  'l'o�� 0 index42_opacity  � o  'o'r�� 0 thetype theType� > 'v'���� n  'v'���� 4  'y'���
� 
cobj� m  '|'�� *� o  'v'y�� 00 propertiestocolumnsref propertiesToColumnsRef� m  '�'���  � k  '�'��� ��� r  '�'���� c  '�'���� n  '�'���� 1  '�'��
� 
qOpa� o  '�'��� 0 thecue theCue� m  '�'�� 
�  
TEXT� o      ���� 0 theitem theItem� ���� r  '�'���� o  '�'����� 0 theitem theItem� n      ��� 4  '�'����
�� 
cobj� l '�'������� n  '�'���� 4  '�'����
�� 
cobj� m  '�'����� *� o  '�'����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  '�'����� $0 thepropertiesref thePropertiesRef��  �
  �	  � ��� l '�'���������  ��  ��  � ��� Z  '�'�������� F  '�'���� E '�'���� o  '�'����� 0 index43_translation_x  � o  '�'����� 0 thetype theType� > '�'���� n  '�'���� 4  '�'����
�� 
cobj� m  '�'����� +� o  '�'����� 00 propertiestocolumnsref propertiesToColumnsRef� m  '�'�����  � k  '�'��� ��� r  '�'���� c  '�'�   n  '�'� 1  '�'���
�� 
qTrX o  '�'����� 0 thecue theCue m  '�'���
�� 
TEXT� o      ���� 0 theitem theItem� �� r  '�'� o  '�'����� 0 theitem theItem n       4  '�'���	
�� 
cobj	 l '�'�
����
 n  '�'� 4  '�'���
�� 
cobj m  '�'����� + o  '�'����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��   o  '�'����� $0 thepropertiesref thePropertiesRef��  ��  ��  �  l '�'���������  ��  ��    Z  '�(C���� F  '�( E '�( o  '�'����� 0 index44_translation_y   o  '�(���� 0 thetype theType > (( n  (( 4  (	(��
�� 
cobj m  ((���� , o  ((	���� 00 propertiestocolumnsref propertiesToColumnsRef m  ((����   k  ((?  r  ((( !  c  (($"#" n  (( $%$ 1  (( ��
�� 
qTrY% o  ((���� 0 thecue theCue# m  ( (#��
�� 
TEXT! o      ���� 0 theitem theItem &��& r  ()(?'(' o  ()(,���� 0 theitem theItem( n      )*) 4  (/(>��+
�� 
cobj+ l (2(=,����, n  (2(=-.- 4  (5(<��/
�� 
cobj/ m  (8(;���� ,. o  (2(5���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  * o  (,(/���� $0 thepropertiesref thePropertiesRef��  ��  ��   010 l (D(D��������  ��  ��  1 232 Z  (D(�45����4 F  (D(^676 E (D(K898 o  (D(G���� 0 index45_rotation  9 o  (G(J�� 0 thetype theType7 > (N(Z:;: n  (N(X<=< 4  (Q(X�>
� 
cobj> m  (T(W�� -= o  (N(Q�� 00 propertiestocolumnsref propertiesToColumnsRef; m  (X(Y��  5 k  (a(�?? @A@ r  (a(pBCB c  (a(lDED n  (a(hFGF 1  (d(h�
� 
qRotG o  (a(d�� 0 thecue theCueE m  (h(k�
� 
TEXTC o      �� 0 theitem theItemA H�H r  (q(�IJI o  (q(t�� 0 theitem theItemJ n      KLK 4  (w(��M
� 
cobjM l (z(�N��N n  (z(�OPO 4  (}(��Q
� 
cobjQ m  (�(��� -P o  (z(}�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  L o  (t(w�� $0 thepropertiesref thePropertiesRef�  ��  ��  3 RSR l (�(�����  �  �  S TUT Z  (�(�VW��V F  (�(�XYX E (�(�Z[Z o  (�(��� 0 index46_scale_x  [ o  (�(��� 0 thetype theTypeY > (�(�\]\ n  (�(�^_^ 4  (�(��`
� 
cobj` m  (�(��� ._ o  (�(��� 00 propertiestocolumnsref propertiesToColumnsRef] m  (�(���  W k  (�(�aa bcb r  (�(�ded c  (�(�fgf n  (�(�hih 1  (�(��
� 
qScXi o  (�(��� 0 thecue theCueg m  (�(��
� 
TEXTe o      �� 0 theitem theItemc j�j r  (�(�klk o  (�(��� 0 theitem theIteml n      mnm 4  (�(��o
� 
cobjo l (�(�p��p n  (�(�qrq 4  (�(��s
� 
cobjs m  (�(��� .r o  (�(��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  n o  (�(��� $0 thepropertiesref thePropertiesRef�  �  �  U tut l (�(�����  �  �  u vwv Z  (�)xy��x F  (�(�z{z E (�(�|}| o  (�(��� 0 index47_scale_y  } o  (�(��� 0 thetype theType{ > (�(�~~ n  (�(���� 4  (�(���
� 
cobj� m  (�(��� /� o  (�(��� 00 propertiestocolumnsref propertiesToColumnsRef m  (�(���  y k  (�)�� ��� r  (�) ��� c  (�(���� n  (�(���� 1  (�(��
� 
qScY� o  (�(��� 0 thecue theCue� m  (�(��
� 
TEXT� o      �� 0 theitem theItem� ��� r  ))��� o  ))�� 0 theitem theItem� n      ��� 4  ))��
� 
cobj� l )
)���� n  )
)��� 4  ))��
� 
cobj� m  ))�� /� o  )
)�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  ))�~�~ $0 thepropertiesref thePropertiesRef�  �  �  w ��� l  ))�}���}  �~x
                if theType is in index48_scale_locked and item 48 of propertiesToColumnsRef is not 0 then
                    set theItem to scale locked of theCue
                    if theItem is true then
                        set item (item 48 of propertiesToColumnsRef) of thePropertiesRef to item 1 of constants48_scale_locked
                    else if theItem is false then
                        set item (item 48 of propertiesToColumnsRef) of thePropertiesRef to item 2 of constants48_scale_locked
                    end if
                end if
 
                if theType is in index49_custom_rendering and item 49 of propertiesToColumnsRef is not 0 then
                    set theItem to custom rendering of theCue
                    if theItem is true then
                        set item (item 49 of propertiesToColumnsRef) of thePropertiesRef to item 1 of constants49_custom_rendering
                    else if theItem is false then
                        set item (item 49 of propertiesToColumnsRef) of thePropertiesRef to item 2 of constants49_custom_rendering
                    end if
                end if
    � ���� 
                                 i f   t h e T y p e   i s   i n   i n d e x 4 8 _ s c a l e _ l o c k e d   a n d   i t e m   4 8   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e I t e m   t o   s c a l e   l o c k e d   o f   t h e C u e 
                                         i f   t h e I t e m   i s   t r u e   t h e n 
                                                 s e t   i t e m   ( i t e m   4 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   1   o f   c o n s t a n t s 4 8 _ s c a l e _ l o c k e d 
                                         e l s e   i f   t h e I t e m   i s   f a l s e   t h e n 
                                                 s e t   i t e m   ( i t e m   4 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   2   o f   c o n s t a n t s 4 8 _ s c a l e _ l o c k e d 
                                         e n d   i f 
                                 e n d   i f 
   
                                 i f   t h e T y p e   i s   i n   i n d e x 4 9 _ c u s t o m _ r e n d e r i n g   a n d   i t e m   4 9   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e I t e m   t o   c u s t o m   r e n d e r i n g   o f   t h e C u e 
                                         i f   t h e I t e m   i s   t r u e   t h e n 
                                                 s e t   i t e m   ( i t e m   4 9   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   1   o f   c o n s t a n t s 4 9 _ c u s t o m _ r e n d e r i n g 
                                         e l s e   i f   t h e I t e m   i s   f a l s e   t h e n 
                                                 s e t   i t e m   ( i t e m   4 9   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   2   o f   c o n s t a n t s 4 9 _ c u s t o m _ r e n d e r i n g 
                                         e n d   i f 
                                 e n d   i f 
  � ��� Z  ))����|�{� F  ))6��� E ))#��� o  ))�z�z 0 index50_do_opacity  � o  ))"�y�y 0 thetype theType� > )&)2��� n  )&)0��� 4  )))0�x�
�x 
cobj� m  ),)/�w�w 2� o  )&))�v�v 00 propertiestocolumnsref propertiesToColumnsRef� m  )0)1�u�u  � k  )9)��� ��� r  )9)D��� n  )9)@��� 1  )<)@�t
�t 
qDoO� o  )9)<�s�s 0 thecue theCue� o      �r�r 0 theitem theItem� ��q� Z  )E)�����p� = )E)J��� o  )E)H�o�o 0 theitem theItem� m  )H)I�n
�n boovtrue� r  )M)h��� n  )M)U��� 4  )P)U�m�
�m 
cobj� m  )S)T�l�l � o  )M)P�k�k 0 constants50_do_opacity  � n      ��� 4  )X)g�j�
�j 
cobj� l )[)f��i�h� n  )[)f��� 4  )^)e�g�
�g 
cobj� m  )a)d�f�f 2� o  )[)^�e�e 00 propertiestocolumnsref propertiesToColumnsRef�i  �h  � o  )U)X�d�d $0 thepropertiesref thePropertiesRef� ��� = )k)p��� o  )k)n�c�c 0 theitem theItem� m  )n)o�b
�b boovfals� ��a� r  )s)���� n  )s){��� 4  )v){�`�
�` 
cobj� m  )y)z�_�_ � o  )s)v�^�^ 0 constants50_do_opacity  � n      ��� 4  )~)��]�
�] 
cobj� l )�)���\�[� n  )�)���� 4  )�)��Z�
�Z 
cobj� m  )�)��Y�Y 2� o  )�)��X�X 00 propertiestocolumnsref propertiesToColumnsRef�\  �[  � o  ){)~�W�W $0 thepropertiesref thePropertiesRef�a  �p  �q  �|  �{  � ��� l )�)��V�U�T�V  �U  �T  � ��� Z  )�*���S�R� F  )�)���� E )�)���� o  )�)��Q�Q 0 index51_do_translation  � o  )�)��P�P 0 thetype theType� > )�)���� n  )�)���� 4  )�)��O�
�O 
cobj� m  )�)��N�N 3� o  )�)��M�M 00 propertiestocolumnsref propertiesToColumnsRef� m  )�)��L�L  � k  )�*�� ��� r  )�)���� n  )�)���� 1  )�)��K
�K 
qDoT� o  )�)��J�J 0 thecue theCue� o      �I�I 0 theitem theItem� ��H� Z  )�*����G� = )�)���� o  )�)��F�F 0 theitem theItem� m  )�)��E
�E boovtrue� r  )�)���� n  )�)���� 4  )�)��D�
�D 
cobj� m  )�)��C�C � o  )�)��B�B 0 constants51_do_translation  � n      ��� 4  )�)��A�
�A 
cobj� l )�)���@�?� n  )�)���� 4  )�)��>�
�> 
cobj� m  )�)��=�= 3� o  )�)��<�< 00 propertiestocolumnsref propertiesToColumnsRef�@  �?  � o  )�)��;�; $0 thepropertiesref thePropertiesRef� ��� = )�)���� o  )�)��:�: 0 theitem theItem� m  )�)��9
�9 boovfals� ��8� r  )�*	� � n  )�)� 4  )�)��7
�7 
cobj m  )�)��6�6  o  )�)��5�5 0 constants51_do_translation    n       4  )�*�4
�4 
cobj l )�*�3�2 n  )�*	 4  )�*�1

�1 
cobj
 m  **�0�0 3	 o  )�)��/�/ 00 propertiestocolumnsref propertiesToColumnsRef�3  �2   o  )�)��.�. $0 thepropertiesref thePropertiesRef�8  �G  �H  �S  �R  �  l **�-�,�+�-  �,  �+    Z  **��*�) F  **, E ** o  **�(�( 0 index52_do_rotation   o  **�'�' 0 thetype theType > **( n  **& 4  **&�&
�& 
cobj m  *"*%�%�% 4 o  **�$�$ 00 propertiestocolumnsref propertiesToColumnsRef m  *&*'�#�#   k  */*�  r  */*: n  */*6  1  *2*6�"
�" 
qDoR  o  */*2�!�! 0 thecue theCue o      � �  0 theitem theItem !�! Z  *;*�"#$�" = *;*@%&% o  *;*>�� 0 theitem theItem& m  *>*?�
� boovtrue# r  *C*^'(' n  *C*K)*) 4  *F*K�+
� 
cobj+ m  *I*J�� * o  *C*F�� 0 constants52_do_rotation  ( n      ,-, 4  *N*]�.
� 
cobj. l *Q*\/��/ n  *Q*\010 4  *T*[�2
� 
cobj2 m  *W*Z�� 41 o  *Q*T�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  - o  *K*N�� $0 thepropertiesref thePropertiesRef$ 343 = *a*f565 o  *a*d�� 0 theitem theItem6 m  *d*e�
� boovfals4 7�7 r  *i*�898 n  *i*q:;: 4  *l*q�<
� 
cobj< m  *o*p�� ; o  *i*l�� 0 constants52_do_rotation  9 n      =>= 4  *t*��?
� 
cobj? l *w*�@�
�	@ n  *w*�ABA 4  *z*��C
� 
cobjC m  *}*��� 4B o  *w*z�� 00 propertiestocolumnsref propertiesToColumnsRef�
  �	  > o  *q*t�� $0 thepropertiesref thePropertiesRef�  �  �  �*  �)   DED l *�*�����  �  �  E FGF Z  *�+HI�� H F  *�*�JKJ E *�*�LML o  *�*����� 0 index53_do_scale  M o  *�*����� 0 thetype theTypeK > *�*�NON n  *�*�PQP 4  *�*���R
�� 
cobjR m  *�*����� 5Q o  *�*����� 00 propertiestocolumnsref propertiesToColumnsRefO m  *�*�����  I k  *�+SS TUT r  *�*�VWV n  *�*�XYX 1  *�*���
�� 
qDoSY o  *�*����� 0 thecue theCueW o      ���� 0 theitem theItemU Z��Z Z  *�+[\]��[ = *�*�^_^ o  *�*����� 0 theitem theItem_ m  *�*���
�� boovtrue\ r  *�*�`a` n  *�*�bcb 4  *�*���d
�� 
cobjd m  *�*����� c o  *�*����� 0 constants53_do_scale  a n      efe 4  *�*���g
�� 
cobjg l *�*�h����h n  *�*�iji 4  *�*���k
�� 
cobjk m  *�*����� 5j o  *�*����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  f o  *�*����� $0 thepropertiesref thePropertiesRef] lml = *�*�non o  *�*����� 0 theitem theItemo m  *�*���
�� boovfalsm p��p r  *�*�qrq n  *�*�sts 4  *�*���u
�� 
cobju m  *�*����� t o  *�*����� 0 constants53_do_scale  r n      vwv 4  *�*���x
�� 
cobjx l *�*�y����y n  *�*�z{z 4  *�*���|
�� 
cobj| m  *�*����� 5{ o  *�*����� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  w o  *�*����� $0 thepropertiesref thePropertiesRef��  ��  ��  �  �   G }~} l ++��������  ��  ��  ~ � Z  +,V������� F  ++"��� E ++��� o  ++���� 0 index54_command  � o  ++���� 0 thetype theType� > ++��� n  ++��� 4  ++���
�� 
cobj� m  ++���� 6� o  ++���� 00 propertiestocolumnsref propertiesToColumnsRef� m  ++����  � k  +%,R�� ��� r  +%+0��� n  +%+,��� 1  +(+,��
�� 
qCOm� o  +%+(���� 0 thecue theCue� o      ���� 0 theitem theItem� ���� Z  +1,R������ = +1+8��� o  +1+4���� 0 theitem theItem� m  +4+7��
�� MICONtOn� r  +;+V��� n  +;+C��� 4  +>+C���
�� 
cobj� m  +A+B���� � o  +;+>���� 0 constants54_command  � n      ��� 4  +F+U���
�� 
cobj� l +I+T������ n  +I+T��� 4  +L+S���
�� 
cobj� m  +O+R���� 6� o  +I+L���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  � o  +C+F���� $0 thepropertiesref thePropertiesRef� ��� = +Y+`��� o  +Y+\�� 0 theitem theItem� m  +\+_�
� MICONtOf� ��� r  +c+~��� n  +c+k��� 4  +f+k��
� 
cobj� m  +i+j�� � o  +c+f�� 0 constants54_command  � n      ��� 4  +n+}��
� 
cobj� l +q+|���� n  +q+|��� 4  +t+{��
� 
cobj� m  +w+z�� 6� o  +q+t�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  +k+n�� $0 thepropertiesref thePropertiesRef� ��� = +�+���� o  +�+��� 0 theitem theItem� m  +�+��
� MICOPrCh� ��� r  +�+���� n  +�+���� 4  +�+���
� 
cobj� m  +�+��� � o  +�+��� 0 constants54_command  � n      ��� 4  +�+���
� 
cobj� l +�+����� n  +�+���� 4  +�+���
� 
cobj� m  +�+��� 6� o  +�+��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  +�+��� $0 thepropertiesref thePropertiesRef� ��� = +�+���� o  +�+��� 0 theitem theItem� m  +�+��
� MICOCtCh� ��� r  +�+���� n  +�+���� 4  +�+���
� 
cobj� m  +�+��� � o  +�+��� 0 constants54_command  � n      ��� 4  +�+���
� 
cobj� l +�+����� n  +�+���� 4  +�+���
� 
cobj� m  +�+��� 6� o  +�+��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  +�+��� $0 thepropertiesref thePropertiesRef� ��� = +�+���� o  +�+��� 0 theitem theItem� m  +�+��
� MICOKyPr� ��� r  +�+���� n  +�+���� 4  +�+���
� 
cobj� m  +�+��� � o  +�+��� 0 constants54_command  � n      ��� 4  +�+���
� 
cobj� l +�+����� n  +�+���� 4  +�+���
� 
cobj� m  +�+��� 6� o  +�+��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  +�+��� $0 thepropertiesref thePropertiesRef� ��� = +�,��� o  +�, �� 0 theitem theItem� m  , ,�
� MICOChPr� ��� r  ,,$��� n  ,,��� 4  ,
,��
� 
cobj� m  ,,�� � o  ,,
�� 0 constants54_command  � n      ��� 4  ,,#��
� 
cobj� l ,,"���� n  ,,"��� 4  ,,!��
� 
cobj� m  ,, �� 6� o  ,,�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  � o  ,,�� $0 thepropertiesref thePropertiesRef� �  � = ,',.    o  ,',*�� 0 theitem theItem  m  ,*,-�
� MICOPiBe    �  r  ,1,N    n  ,1,;    4  ,4,;� 
� 
cobj  m  ,7,:��   o  ,1,4�~�~ 0 constants54_command    n       	 
 	 4  ,>,M�} 
�} 
cobj  l ,A,L �|�{  n  ,A,L    4  ,D,K�z 
�z 
cobj  m  ,G,J�y�y 6  o  ,A,D�x�x 00 propertiestocolumnsref propertiesToColumnsRef�|  �{   
 o  ,;,>�w�w $0 thepropertiesref thePropertiesRef�  ��  ��  ��  ��  �     l ,W,W�v�u�t�v  �u  �t        Z  ,W,�  �s�r  F  ,W,q    E ,W,^    o  ,W,Z�q�q 0 index55_channel    o  ,Z,]�p�p 0 thetype theType  > ,a,m    n  ,a,k    4  ,d,k�o 
�o 
cobj  m  ,g,j�n�n 7  o  ,a,d�m�m 00 propertiestocolumnsref propertiesToColumnsRef  m  ,k,l�l�l    k  ,t,�      !   r  ,t,� " # " c  ,t, $ % $ n  ,t,{ & ' & 1  ,w,{�k
�k 
qCHa ' o  ,t,w�j�j 0 thecue theCue % m  ,{,~�i
�i 
TEXT # o      �h�h 0 theitem theItem !  (�g ( r  ,�,� ) * ) o  ,�,��f�f 0 theitem theItem * n       + , + 4  ,�,��e -
�e 
cobj - l ,�,� .�d�c . n  ,�,� / 0 / 4  ,�,��b 1
�b 
cobj 1 m  ,�,��a�a 7 0 o  ,�,��`�` 00 propertiestocolumnsref propertiesToColumnsRef�d  �c   , o  ,�,��_�_ $0 thepropertiesref thePropertiesRef�g  �s  �r     2 3 2 l ,�,��^�]�\�^  �]  �\   3  4 5 4 Z  ,�,� 6 7�[�Z 6 F  ,�,� 8 9 8 E ,�,� : ; : o  ,�,��Y�Y 0 index56_byte_one   ; o  ,�,��X�X 0 thetype theType 9 > ,�,� < = < n  ,�,� > ? > 4  ,�,��W @
�W 
cobj @ m  ,�,��V�V 8 ? o  ,�,��U�U 00 propertiestocolumnsref propertiesToColumnsRef = m  ,�,��T�T   7 Z  ,�,� A B�S�R A > ,�,� C D C n  ,�,� E F E 1  ,�,��Q
�Q 
qCOm F o  ,�,��P�P 0 thecue theCue D m  ,�,��O
�O MICOPiBe B k  ,�,� G G  H I H r  ,�,� J K J c  ,�,� L M L n  ,�,� N O N 1  ,�,��N
�N 
qBy1 O o  ,�,��M�M 0 thecue theCue M m  ,�,��L
�L 
TEXT K o      �K�K 0 theitem theItem I  P�J P r  ,�,� Q R Q o  ,�,��I�I 0 theitem theItem R n       S T S 4  ,�,��H U
�H 
cobj U l ,�,� V�G�F V n  ,�,� W X W 4  ,�,��E Y
�E 
cobj Y m  ,�,��D�D 8 X o  ,�,��C�C 00 propertiestocolumnsref propertiesToColumnsRef�G  �F   T o  ,�,��B�B $0 thepropertiesref thePropertiesRef�J  �S  �R  �[  �Z   5  Z [ Z l ,�,��A�@�?�A  �@  �?   [  \ ] \ Z  ,�-v ^ _�>�= ^ F  ,�- ` a ` E ,�-  b c b o  ,�,��<�< 0 index57_byte_two   c o  ,�,��;�; 0 thetype theType a > -- d e d n  -- f g f 4  --�: h
�: 
cobj h m  -	-�9�9 9 g o  --�8�8 00 propertiestocolumnsref propertiesToColumnsRef e m  --�7�7   _ Z  --r i j�6�5 i F  --E k l k F  --3 m n m > --! o p o n  -- q r q 1  --�4
�4 
qCOm r o  --�3�3 0 thecue theCue p m  -- �2
�2 MICOPiBe n > -$-/ s t s n  -$-+ u v u 1  -'-+�1
�1 
qCOm v o  -$-'�0�0 0 thecue theCue t m  -+-.�/
�/ MICOPrCh l > -6-A w x w n  -6-= y z y l 	-9-= {�.�- { 1  -9-=�,
�, 
qCOm�.  �-   z o  -6-9�+�+ 0 thecue theCue x m  -=-@�*
�* MICOChPr j k  -H-n | |  } ~ } r  -H-W  �  c  -H-S � � � n  -H-O � � � 1  -K-O�)
�) 
qBy2 � o  -H-K�(�( 0 thecue theCue � m  -O-R�'
�' 
TEXT � o      �&�& 0 theitem theItem ~  ��% � r  -X-n � � � o  -X-[�$�$ 0 theitem theItem � n       � � � 4  -^-m�# �
�# 
cobj � l -a-l ��"�! � n  -a-l � � � 4  -d-k�  �
�  
cobj � m  -g-j�� 9 � o  -a-d�� 00 propertiestocolumnsref propertiesToColumnsRef�"  �!   � o  -[-^�� $0 thepropertiesref thePropertiesRef�%  �6  �5  �>  �=   ]  � � � l -w-w����  �  �   �  � � � Z  -w-� � ��� � F  -w-� � � � E -w-~ � � � o  -w-z�� 0 index58_byte_combo   � o  -z-}�� 0 thetype theType � > -�-� � � � n  -�-� � � � 4  -�-�� �
� 
cobj � m  -�-��� : � o  -�-��� 00 propertiestocolumnsref propertiesToColumnsRef � m  -�-���   � Z  -�-� � ��� � = -�-� � � � n  -�-� � � � 1  -�-��
� 
qCOm � o  -�-��� 0 thecue theCue � m  -�-��
� MICOPiBe � k  -�-� � �  � � � r  -�-� � � � c  -�-� � � � l -�-� ��� � \  -�-� � � � l -�-� ��
�	 � n  -�-� � � � 1  -�-��
� 
qBy3 � o  -�-��� 0 thecue theCue�
  �	   � m  -�-���  �  �   � m  -�-��
� 
TEXT � o      �� 0 theitem theItem �  �� � r  -�-� � � � o  -�-��� 0 theitem theItem � n       � � � 4  -�-�� �
� 
cobj � l -�-� �� �� � n  -�-� � � � 4  -�-��� �
�� 
cobj � m  -�-����� : � o  -�-����� 00 propertiestocolumnsref propertiesToColumnsRef�   ��   � o  -�-����� $0 thepropertiesref thePropertiesRef�  �  �  �  �   �  � � � l -�-���������  ��  ��   �  � � � Z  -�.@ � ����� � F  -�-� � � � E -�-� � � � o  -�-����� 0 index59_end_value   � o  -�-����� 0 thetype theType � > -�-� � � � n  -�-� � � � 4  -�-��� �
�� 
cobj � m  -�-����� ; � o  -�-����� 00 propertiestocolumnsref propertiesToColumnsRef � m  -�-�����   � k  -�.< � �  � � � Z  -�.% � ��� � � > -�-� � � � n  -�-� � � � 1  -�-���
�� 
qCOm � o  -�-����� 0 thecue theCue � m  -�-���
�� MICOPiBe � r  . . � � � c  . . � � � n  . . � � � 1  ..��
�� 
qEVA � o  . .���� 0 thecue theCue � m  ..
��
�� 
TEXT � o      ���� 0 theitem theItem��   � r  ..% � � � c  ..! � � � l .. ����� � \  .. � � � l .. ����� � n  .. � � � 1  ..��
�� 
qEVA � o  ..���� 0 thecue theCue��  ��   � m  ..����  ��  ��   � m  .. ��
�� 
TEXT � o      ���� 0 theitem theItem �  ��� � r  .&.< � � � o  .&.)���� 0 theitem theItem � n       � � � 4  .,.;�� �
�� 
cobj � l ./.: ����� � n  ./.: � � � 4  .2.9�� �
�� 
cobj � m  .5.8���� ; � o  ./.2���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��   � o  .).,���� $0 thepropertiesref thePropertiesRef��  ��  ��   �  � � � l .A.A��������  ��  ��   �  � � � Z  .A.� � ����� � F  .A.[ � � � E .A.H � � � o  .A.D���� 0 index60_fade   � o  .D.G���� 0 thetype theType � > .K.W � � � n  .K.U � � � 4  .N.U�� �
�� 
cobj � m  .Q.T���� < � o  .K.N���� 00 propertiestocolumnsref propertiesToColumnsRef � m  .U.V����   � k  .^.� � �  � � � r  .^.i! !!  n  .^.e!!! 1  .a.e��
�� 
qDoF! o  .^.a���� 0 thecue theCue! o      ���� 0 theitem theItem � !��! Z  .j.�!!!��! = .j.q!!	! o  .j.m���� 0 theitem theItem!	 m  .m.p��
�� YorNYyes! r  .t.�!
!!
 n  .t.|!!! 4  .w.|��!
�� 
cobj! m  .z.{���� ! o  .t.w���� 0 constants60_fade  ! n      !!! 4  ..���!
�� 
cobj! l .�.�!��! n  .�.�!!! 4  .�.��!
� 
cobj! m  .�.��� <! o  .�.��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  ! o  .|.�� $0 thepropertiesref thePropertiesRef! !!! = .�.�!!! o  .�.��� 0 theitem theItem! m  .�.��
� YorNNnoo! !�! r  .�.�!!! n  .�.�!!! 4  .�.��!
� 
cobj! m  .�.��� ! o  .�.��� 0 constants60_fade  ! n      ! !!!  4  .�.��!"
� 
cobj!" l .�.�!#��!# n  .�.�!$!%!$ 4  .�.��!&
� 
cobj!& m  .�.��� <!% o  .�.��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  !! o  .�.��� $0 thepropertiesref thePropertiesRef�  ��  ��  ��  ��   � !'!(!' l .�.�����  �  �  !( !)!*!) Z  .�/X!+!,��!+ F  .�.�!-!.!- E .�.�!/!0!/ o  .�.��� 0 index61_command_format  !0 o  .�.��� 0 thetype theType!. > .�.�!1!2!1 n  .�.�!3!4!3 4  .�.��!5
� 
cobj!5 m  .�.��� =!4 o  .�.��� 00 propertiestocolumnsref propertiesToColumnsRef!2 m  .�.���  !, k  .�/T!6!6 !7!8!7 r  .�.�!9!:!9 c  .�.�!;!<!; n  .�.�!=!>!= 1  .�.��
� 
qFor!> o  .�.��� 0 thecue theCue!< m  .�.��
� 
TEXT!: o      �� 0 theitem theItem!8 !?!@!? Z  .�/=!A!B�!C!A E .�.�!D!E!D o  .�.���  0 translation61_command_format  !E o  .�.��� 0 theitem theItem!B Y  .�//!F�!G!H!I!F Z  //*!J!K��!J = //!L!M!L o  //
�� 0 theitem theItem!M n  /
/!N!O!N 4  //�!P
� 
cobj!P o  //�� 0 j  !O o  /
/��  0 translation61_command_format  !K k  //&!Q!Q !R!S!R r  //$!T!U!T n  // !V!W!V 4  // �!X
� 
cobj!X l //!Y��!Y [  //!Z![!Z o  //�� 0 j  ![ m  //�� �  �  !W o  //��  0 translation61_command_format  !U o      �� 0 theitem theItem!S !\�!\  S  /%/&�  �  �  � 0 j  !G m  .�.��� !H I .�/�!]�
� .corecnte****       ****!] o  .�.���  0 translation61_command_format  �  !I m  //�� �  !C r  /2/=!^!_!^ b  /2/9!`!a!` o  /2/5�� 0 theitem theItem!a m  /5/8!b!b �!c!c    ( n o   m a t c h )!_ o      �� 0 theitem theItem!@ !d�!d r  />/T!e!f!e o  />/A�� 0 theitem theItem!f n      !g!h!g 4  /D/S�!i
� 
cobj!i l /G/R!j��!j n  /G/R!k!l!k 4  /J/Q�!m
� 
cobj!m m  /M/P�~�~ =!l o  /G/J�}�} 00 propertiestocolumnsref propertiesToColumnsRef�  �  !h o  /A/D�|�| $0 thepropertiesref thePropertiesRef�  �  �  !* !n!o!n l /Y/Y�{�z�y�{  �z  �y  !o !p!q!p Z  /Y/�!r!s�x�w!r F  /Y/s!t!u!t E /Y/`!v!w!v o  /Y/\�v�v 0 index62_command_number  !w o  /\/_�u�u 0 thetype theType!u > /c/o!x!y!x n  /c/m!z!{!z 4  /f/m�t!|
�t 
cobj!| m  /i/l�s�s >!{ o  /c/f�r�r 00 propertiestocolumnsref propertiesToColumnsRef!y m  /m/n�q�q  !s k  /v/�!}!} !~!!~ r  /v/�!�!�!� c  /v/�!�!�!� n  /v/}!�!�!� 1  /y/}�p
�p 
qCom!� o  /v/y�o�o 0 thecue theCue!� m  /}/��n
�n 
TEXT!� o      �m�m 0 theitem theItem! !�!�!� Z  /�/�!�!��l!�!� E /�/�!�!�!� o  /�/��k�k  0 translation62_command_number  !� o  /�/��j�j 0 theitem theItem!� Y  /�/�!��i!�!�!�!� Z  /�/�!�!��h�g!� = /�/�!�!�!� o  /�/��f�f 0 theitem theItem!� n  /�/�!�!�!� 4  /�/��e!�
�e 
cobj!� o  /�/��d�d 0 j  !� o  /�/��c�c  0 translation62_command_number  !� k  /�/�!�!� !�!�!� r  /�/�!�!�!� n  /�/�!�!�!� 4  /�/��b!�
�b 
cobj!� l /�/�!��a�`!� [  /�/�!�!�!� o  /�/��_�_ 0 j  !� m  /�/��^�^ �a  �`  !� o  /�/��]�]  0 translation62_command_number  !� o      �\�\ 0 theitem theItem!� !��[!�  S  /�/��[  �h  �g  �i 0 j  !� m  /�/��Z�Z !� I /�/��Y!��X
�Y .corecnte****       ****!� o  /�/��W�W  0 translation62_command_number  �X  !� m  /�/��V�V �l  !� r  /�/�!�!�!� b  /�/�!�!�!� o  /�/��U�U 0 theitem theItem!� m  /�/�!�!� �!�!�    ( n o   m a t c h )!� o      �T�T 0 theitem theItem!� !��S!� r  /�/�!�!�!� o  /�/��R�R 0 theitem theItem!� n      !�!�!� 4  /�/��Q!�
�Q 
cobj!� l /�/�!��P�O!� n  /�/�!�!�!� 4  /�/��N!�
�N 
cobj!� m  /�/��M�M >!� o  /�/��L�L 00 propertiestocolumnsref propertiesToColumnsRef�P  �O  !� o  /�/��K�K $0 thepropertiesref thePropertiesRef�S  �x  �w  !q !�!�!� l /�/��J�I�H�J  �I  �H  !� !�!�!� Z  /�09!�!��G�F!� F  /�0!�!�!� E /�/�!�!�!� o  /�/��E�E 0 index63_q__number  !� o  /�/��D�D 0 thetype theType!� > /�0!�!�!� n  /�0!�!�!� 4  /�0�C!�
�C 
cobj!� m  00�B�B ?!� o  /�/��A�A 00 propertiestocolumnsref propertiesToColumnsRef!� m  00�@�@  !� k  005!�!� !�!�!� r  00!�!�!� c  00!�!�!� n  00!�!�!� 1  00�?
�? 
qmsN!� o  00�>�> 0 thecue theCue!� m  00�=
�= 
TEXT!� o      �<�< 0 theitem theItem!� !��;!� r  005!�!�!� o  00"�:�: 0 theitem theItem!� n      !�!�!� 4  0%04�9!�
�9 
cobj!� l 0(03!��8�7!� n  0(03!�!�!� 4  0+02�6!�
�6 
cobj!� m  0.01�5�5 ?!� o  0(0+�4�4 00 propertiestocolumnsref propertiesToColumnsRef�8  �7  !� o  0"0%�3�3 $0 thepropertiesref thePropertiesRef�;  �G  �F  !� !�!�!� l 0:0:�2�1�0�2  �1  �0  !� !�!�!� Z  0:0�!�!��/�.!� F  0:0T!�!�!� E 0:0A!�!�!� o  0:0=�-�- 0 index64_q__list  !� o  0=0@�,�, 0 thetype theType!� > 0D0P!�!�!� n  0D0N!�!�!� 4  0G0N�+!�
�+ 
cobj!� m  0J0M�*�* @!� o  0D0G�)�) 00 propertiestocolumnsref propertiesToColumnsRef!� m  0N0O�(�(  !� k  0W0}!�!� !�!�!� r  0W0f!�!�!� c  0W0b!�!�!� n  0W0^!�!�!� 1  0Z0^�'
�' 
qmsL!� o  0W0Z�&�& 0 thecue theCue!� m  0^0a�%
�% 
TEXT!� o      �$�$ 0 theitem theItem!� !��#!� r  0g0}!�!�!� o  0g0j�"�" 0 theitem theItem!� n      !�!�!� 4  0m0|�!!�
�! 
cobj!� l 0p0{!�� �!� n  0p0{!�!�!� 4  0s0z�!�
� 
cobj!� m  0v0y�� @!� o  0p0s�� 00 propertiestocolumnsref propertiesToColumnsRef�   �  !� o  0j0m�� $0 thepropertiesref thePropertiesRef�#  �/  �.  !� !�!�!� l 0�0�����  �  �  !� !�!�!� Z  0�0�!�!���!� F  0�0�!�" !� E 0�0�""" o  0�0��� 0 index65_q__path  " o  0�0��� 0 thetype theType"  > 0�0�""" n  0�0�""" 4  0�0��"
� 
cobj" m  0�0��� A" o  0�0��� 00 propertiestocolumnsref propertiesToColumnsRef" m  0�0���  !� k  0�0�"" "	"
"	 r  0�0�""" c  0�0�""" n  0�0�""" 1  0�0��
� 
qmsP" o  0�0��� 0 thecue theCue" m  0�0��
� 
TEXT" o      �� 0 theitem theItem"
 "�" r  0�0�""" o  0�0��
�
 0 theitem theItem" n      """ 4  0�0��	"
�	 
cobj" l 0�0�"��" n  0�0�""" 4  0�0��"
� 
cobj" m  0�0��� A" o  0�0��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  " o  0�0��� $0 thepropertiesref thePropertiesRef�  �  �  !� """ l 0�0���� �  �  �   " """ Z  0�1"" ����" F  0�0�"!"""! E 0�0�"#"$"# o  0�0����� 0 index66_macro  "$ o  0�0����� 0 thetype theType"" > 0�0�"%"&"% n  0�0�"'"("' 4  0�0���")
�� 
cobj") m  0�0����� B"( o  0�0����� 00 propertiestocolumnsref propertiesToColumnsRef"& m  0�0�����  "  k  0�1"*"* "+","+ r  0�0�"-"."- c  0�0�"/"0"/ n  0�0�"1"2"1 1  0�0���
�� 
qMac"2 o  0�0����� 0 thecue theCue"0 m  0�0���
�� 
TEXT". o      ���� 0 theitem theItem", "3��"3 r  0�1"4"5"4 o  0�0����� 0 theitem theItem"5 n      "6"7"6 4  0�1��"8
�� 
cobj"8 l 1 1"9����"9 n  1 1":";": 4  11
��"<
�� 
cobj"< m  11	���� B"; o  1 1���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  "7 o  0�0����� $0 thepropertiesref thePropertiesRef��  ��  ��  " "=">"= l 11��������  ��  ��  "> "?"@"? Z  11Y"A"B����"A F  11,"C"D"C E 11"E"F"E o  11���� 0 index67_control_number  "F o  11���� 0 thetype theType"D > 11("G"H"G n  11&"I"J"I 4  11&��"K
�� 
cobj"K m  1"1%���� C"J o  11���� 00 propertiestocolumnsref propertiesToColumnsRef"H m  1&1'����  "B k  1/1U"L"L "M"N"M r  1/1>"O"P"O c  1/1:"Q"R"Q n  1/16"S"T"S 1  1216��
�� 
qCNt"T o  1/12���� 0 thecue theCue"R m  1619��
�� 
TEXT"P o      ���� 0 theitem theItem"N "U��"U r  1?1U"V"W"V o  1?1B���� 0 theitem theItem"W n      "X"Y"X 4  1E1T��"Z
�� 
cobj"Z l 1H1S"[����"[ n  1H1S"\"]"\ 4  1K1R��"^
�� 
cobj"^ m  1N1Q���� C"] o  1H1K���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  "Y o  1B1E���� $0 thepropertiesref thePropertiesRef��  ��  ��  "@ "_"`"_ l 1Z1Z��������  ��  ��  "` "a"b"a Z  1Z1�"c"d����"c F  1Z1t"e"f"e E 1Z1a"g"h"g o  1Z1]���� 0 index68_control_value  "h o  1]1`���� 0 thetype theType"f > 1d1p"i"j"i n  1d1n"k"l"k 4  1g1n��"m
�� 
cobj"m m  1j1m���� D"l o  1d1g���� 00 propertiestocolumnsref propertiesToColumnsRef"j m  1n1o����  "d k  1w1�"n"n "o"p"o r  1w1�"q"r"q c  1w1�"s"t"s n  1w1~"u"v"u 1  1z1~��
�� 
qCNv"v o  1w1z���� 0 thecue theCue"t m  1~1���
�� 
TEXT"r o      ���� 0 theitem theItem"p "w��"w r  1�1�"x"y"x o  1�1����� 0 theitem theItem"y n      "z"{"z 4  1�1���"|
�� 
cobj"| l 1�1�"}���"} n  1�1�"~""~ 4  1�1��"�
� 
cobj"� m  1�1��� D" o  1�1��� 00 propertiestocolumnsref propertiesToColumnsRef��  �  "{ o  1�1��� $0 thepropertiesref thePropertiesRef��  ��  ��  "b "�"�"� l 1�1�����  �  �  "� "�"�"� Z  1�1�"�"���"� F  1�1�"�"�"� E 1�1�"�"�"� o  1�1��� 0 index69_hours  "� o  1�1��� 0 thetype theType"� > 1�1�"�"�"� n  1�1�"�"�"� 4  1�1��"�
� 
cobj"� m  1�1��� E"� o  1�1��� 00 propertiestocolumnsref propertiesToColumnsRef"� m  1�1���  "� k  1�1�"�"� "�"�"� r  1�1�"�"�"� c  1�1�"�"�"� n  1�1�"�"�"� 1  1�1��
� 
qHou"� o  1�1��� 0 thecue theCue"� m  1�1��
� 
TEXT"� o      �� 0 theitem theItem"� "��"� r  1�1�"�"�"� o  1�1��� 0 theitem theItem"� n      "�"�"� 4  1�1��"�
� 
cobj"� l 1�1�"���"� n  1�1�"�"�"� 4  1�1��"�
� 
cobj"� m  1�1��� E"� o  1�1��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  "� o  1�1��� $0 thepropertiesref thePropertiesRef�  �  �  "� "�"�"� l 1�1�����  �  �  "� "�"�"� Z  1�21"�"���"� F  1�2"�"�"� E 1�1�"�"�"� o  1�1��� 0 index70_minutes  "� o  1�1��� 0 thetype theType"� > 1�2 "�"�"� n  1�1�"�"�"� 4  1�1��"�
� 
cobj"� m  1�1��� F"� o  1�1��� 00 propertiestocolumnsref propertiesToColumnsRef"� m  1�1���  "� k  22-"�"� "�"�"� r  22"�"�"� c  22"�"�"� n  22"�"�"� 1  2
2�
� 
qMin"� o  22
�� 0 thecue theCue"� m  22�
� 
TEXT"� o      �� 0 theitem theItem"� "��"� r  22-"�"�"� o  22�� 0 theitem theItem"� n      "�"�"� 4  22,�"�
� 
cobj"� l 2 2+"����"� n  2 2+"�"�"� 4  2#2*��"�
�� 
cobj"� m  2&2)���� F"� o  2 2#���� 00 propertiestocolumnsref propertiesToColumnsRef�  ��  "� o  22���� $0 thepropertiesref thePropertiesRef�  �  �  "� "�"�"� l 2222��������  ��  ��  "� "�"�"� Z  222y"�"�����"� F  222L"�"�"� E 2229"�"�"� o  2225���� 0 index71_seconds  "� o  2528���� 0 thetype theType"� > 2<2H"�"�"� n  2<2F"�"�"� 4  2?2F��"�
�� 
cobj"� m  2B2E���� G"� o  2<2?���� 00 propertiestocolumnsref propertiesToColumnsRef"� m  2F2G����  "� k  2O2u"�"� "�"�"� r  2O2^"�"�"� c  2O2Z"�"�"� n  2O2V"�"�"� 1  2R2V�
� 
qSec"� o  2O2R�~�~ 0 thecue theCue"� m  2V2Y�}
�} 
TEXT"� o      �|�| 0 theitem theItem"� "��{"� r  2_2u"�"�"� o  2_2b�z�z 0 theitem theItem"� n      "�"�"� 4  2e2t�y"�
�y 
cobj"� l 2h2s"��x�w"� n  2h2s"�"�"� 4  2k2r�v"�
�v 
cobj"� m  2n2q�u�u G"� o  2h2k�t�t 00 propertiestocolumnsref propertiesToColumnsRef�x  �w  "� o  2b2e�s�s $0 thepropertiesref thePropertiesRef�{  ��  ��  "� "�"�"� l 2z2z�r�q�p�r  �q  �p  "� "�"�"� Z  2z2�"�"��o�n"� F  2z2�"�"�"� E 2z2�"�"�"� o  2z2}�m�m 0 index72_frames  "� o  2}2��l�l 0 thetype theType"� > 2�2�"�"�"� n  2�2�"�"�"� 4  2�2��k"�
�k 
cobj"� m  2�2��j�j H"� o  2�2��i�i 00 propertiestocolumnsref propertiesToColumnsRef"� m  2�2��h�h  "� k  2�2�"�"� "�"�"� r  2�2�"�"�"� c  2�2�"�"�"� n  2�2�"�"�"� 1  2�2��g
�g 
qFra"� o  2�2��f�f 0 thecue theCue"� m  2�2��e
�e 
TEXT"� o      �d�d 0 theitem theItem"� "��c"� r  2�2�# ##  o  2�2��b�b 0 theitem theItem# n      ### 4  2�2��a#
�a 
cobj# l 2�2�#�`�_# n  2�2�### 4  2�2��^#
�^ 
cobj# m  2�2��]�] H# o  2�2��\�\ 00 propertiestocolumnsref propertiesToColumnsRef�`  �_  # o  2�2��[�[ $0 thepropertiesref thePropertiesRef�c  �o  �n  "� #	#
#	 l 2�2��Z�Y�X�Z  �Y  �X  #
 ### Z  2�3	##�W�V# F  2�2�### E 2�2�### o  2�2��U�U 0 index73_subframes  # o  2�2��T�T 0 thetype theType# > 2�2�### n  2�2�### 4  2�2��S#
�S 
cobj# m  2�2��R�R I# o  2�2��Q�Q 00 propertiestocolumnsref propertiesToColumnsRef# m  2�2��P�P  # k  2�3## ### r  2�2�### c  2�2�### n  2�2�## # 1  2�2��O
�O 
qSFr#  o  2�2��N�N 0 thecue theCue# m  2�2��M
�M 
TEXT# o      �L�L 0 theitem theItem# #!�K#! r  2�3#"###" o  2�2��J�J 0 theitem theItem## n      #$#%#$ 4  2�3�I#&
�I 
cobj#& l 2�3#'�H�G#' n  2�3#(#)#( 4  2�3�F#*
�F 
cobj#* m  2�3�E�E I#) o  2�2��D�D 00 propertiestocolumnsref propertiesToColumnsRef�H  �G  #% o  2�2��C�C $0 thepropertiesref thePropertiesRef�K  �W  �V  # #+#,#+ l 3
3
�B�A�@�B  �A  �@  #, #-#.#- Z  3
3�#/#0�?�>#/ F  3
3$#1#2#1 E 3
3#3#4#3 o  3
3�=�= 0 index74_send_time_with_set  #4 o  33�<�< 0 thetype theType#2 > 33 #5#6#5 n  33#7#8#7 4  33�;#9
�; 
cobj#9 m  33�:�: J#8 o  33�9�9 00 propertiestocolumnsref propertiesToColumnsRef#6 m  33�8�8  #0 k  3'3�#:#: #;#<#; r  3'32#=#>#= n  3'3.#?#@#? 1  3*3.�7
�7 
qSTW#@ o  3'3*�6�6 0 thecue theCue#> o      �5�5 0 theitem theItem#< #A�4#A Z  333�#B#C#D�3#B = 3338#E#F#E o  3336�2�2 0 theitem theItem#F m  3637�1
�1 boovtrue#C r  3;3V#G#H#G n  3;3C#I#J#I 4  3>3C�0#K
�0 
cobj#K m  3A3B�/�/ #J o  3;3>�.�. "0 constants74_send_time_with_set  #H n      #L#M#L 4  3F3U�-#N
�- 
cobj#N l 3I3T#O�,�+#O n  3I3T#P#Q#P 4  3L3S�*#R
�* 
cobj#R m  3O3R�)�) J#Q o  3I3L�(�( 00 propertiestocolumnsref propertiesToColumnsRef�,  �+  #M o  3C3F�'�' $0 thepropertiesref thePropertiesRef#D #S#T#S = 3Y3^#U#V#U o  3Y3\�&�& 0 theitem theItem#V m  3\3]�%
�% boovfals#T #W�$#W r  3a3|#X#Y#X n  3a3i#Z#[#Z 4  3d3i�##\
�# 
cobj#\ m  3g3h�"�" #[ o  3a3d�!�! "0 constants74_send_time_with_set  #Y n      #]#^#] 4  3l3{� #_
�  
cobj#_ l 3o3z#`��#` n  3o3z#a#b#a 4  3r3y�#c
� 
cobj#c m  3u3x�� J#b o  3o3r�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  #^ o  3i3l�� $0 thepropertiesref thePropertiesRef�$  �3  �4  �?  �>  #. #d#e#d l 3�3�����  �  �  #e #f#g#f Z  3�3�#h#i��#h F  3�3�#j#k#j E 3�3�#l#m#l o  3�3��� 0 index75_sysex_message  #m o  3�3��� 0 thetype theType#k > 3�3�#n#o#n n  3�3�#p#q#p 4  3�3��#r
� 
cobj#r m  3�3��� K#q o  3�3��� 00 propertiestocolumnsref propertiesToColumnsRef#o m  3�3���  #i k  3�3�#s#s #t#u#t r  3�3�#v#w#v c  3�3�#x#y#x n  3�3�#z#{#z 1  3�3��
� 
qSEX#{ o  3�3��� 0 thecue theCue#y m  3�3��
� 
TEXT#w o      �� 0 theitem theItem#u #|�
#| r  3�3�#}#~#} o  3�3��	�	 0 theitem theItem#~ n      ##�# 4  3�3��#�
� 
cobj#� l 3�3�#���#� n  3�3�#�#�#� 4  3�3��#�
� 
cobj#� m  3�3��� K#� o  3�3��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  #� o  3�3��� $0 thepropertiesref thePropertiesRef�
  �  �  #g #�#�#� l  3�3��#�#��  #�5/
                if theType is in index76_midi_destination and item 76 of propertiesToColumnsRef is not 0 then
                    set theItem to midi destination of theCue as string
                    set item (item 76 of propertiesToColumnsRef) of thePropertiesRef to theItem
                end if
    #� �#�#�^ 
                                 i f   t h e T y p e   i s   i n   i n d e x 7 6 _ m i d i _ d e s t i n a t i o n   a n d   i t e m   7 6   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e I t e m   t o   m i d i   d e s t i n a t i o n   o f   t h e C u e   a s   s t r i n g 
                                         s e t   i t e m   ( i t e m   7 6   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   t h e I t e m 
                                 e n d   i f 
  #� #�#�#� Z  3�4#�#�� ��#� F  3�3�#�#�#� E 3�3�#�#�#� o  3�3����� 0 index77_start_time_offset  #� o  3�3����� 0 thetype theType#� > 3�3�#�#�#� n  3�3�#�#�#� 4  3�3���#�
�� 
cobj#� m  3�3����� M#� o  3�3����� 00 propertiestocolumnsref propertiesToColumnsRef#� m  3�3�����  #� k  3�4#�#� #�#�#� r  3�3�#�#�#� n  3�3�#�#�#� 1  3�3���
�� 
qStA#� o  3�3����� 0 thecue theCue#� o      ���� 0 thetime theTime#� #�#�#� r  3�4#�#�#� n 3�3�#�#�#� I  3�3���#����� 0 makehhmmsssss makeHHMMSSsss#� #���#� o  3�3����� 0 thetime theTime��  ��  #�  f  3�3�#� o      ���� 0 theitem theItem#� #���#� r  44#�#�#� o  44���� 0 theitem theItem#� n      #�#�#� 4  4	4��#�
�� 
cobj#� l 44#�����#� n  44#�#�#� 4  44��#�
�� 
cobj#� m  44���� M#� o  44���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  #� o  44	���� $0 thepropertiesref thePropertiesRef��  �   ��  #� #�#�#� l  44��#�#���  #���
                if theType is in index78_fire_next_cue_when_loop_ends and item 78 of propertiesToColumnsRef is not 0 then
                    set theItem to fire next cue when loop ends of theCue
                    if theItem is true then
                        set item (item 78 of propertiesToColumnsRef) of thePropertiesRef to item 1 of constants78_fire_next_cue_when_loop_ends
                    else if theItem is false then
                        set item (item 78 of propertiesToColumnsRef) of thePropertiesRef to item 2 of constants78_fire_next_cue_when_loop_ends
                    end if
                end if
 
                if theType is in index79_stop_target_when_loop_ends and item 79 of propertiesToColumnsRef is not 0 then
                    set theItem to stop target when loop ends of theCue
                    if theItem is true then
                        set item (item 79 of propertiesToColumnsRef) of thePropertiesRef to item 1 of constants79_stop_target_when_loop_ends
                    else if theItem is false then
                        set item (item 79 of propertiesToColumnsRef) of thePropertiesRef to item 2 of constants79_stop_target_when_loop_ends
                    end if
                end if
    #� �#�#�	� 
                                 i f   t h e T y p e   i s   i n   i n d e x 7 8 _ f i r e _ n e x t _ c u e _ w h e n _ l o o p _ e n d s   a n d   i t e m   7 8   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e I t e m   t o   f i r e   n e x t   c u e   w h e n   l o o p   e n d s   o f   t h e C u e 
                                         i f   t h e I t e m   i s   t r u e   t h e n 
                                                 s e t   i t e m   ( i t e m   7 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   1   o f   c o n s t a n t s 7 8 _ f i r e _ n e x t _ c u e _ w h e n _ l o o p _ e n d s 
                                         e l s e   i f   t h e I t e m   i s   f a l s e   t h e n 
                                                 s e t   i t e m   ( i t e m   7 8   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   2   o f   c o n s t a n t s 7 8 _ f i r e _ n e x t _ c u e _ w h e n _ l o o p _ e n d s 
                                         e n d   i f 
                                 e n d   i f 
   
                                 i f   t h e T y p e   i s   i n   i n d e x 7 9 _ s t o p _ t a r g e t _ w h e n _ l o o p _ e n d s   a n d   i t e m   7 9   o f   p r o p e r t i e s T o C o l u m n s R e f   i s   n o t   0   t h e n 
                                         s e t   t h e I t e m   t o   s t o p   t a r g e t   w h e n   l o o p   e n d s   o f   t h e C u e 
                                         i f   t h e I t e m   i s   t r u e   t h e n 
                                                 s e t   i t e m   ( i t e m   7 9   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   1   o f   c o n s t a n t s 7 9 _ s t o p _ t a r g e t _ w h e n _ l o o p _ e n d s 
                                         e l s e   i f   t h e I t e m   i s   f a l s e   t h e n 
                                                 s e t   i t e m   ( i t e m   7 9   o f   p r o p e r t i e s T o C o l u m n s R e f )   o f   t h e P r o p e r t i e s R e f   t o   i t e m   2   o f   c o n s t a n t s 7 9 _ s t o p _ t a r g e t _ w h e n _ l o o p _ e n d s 
                                         e n d   i f 
                                 e n d   i f 
  #� #�#�#� Z  44n#�#�����#� F  448#�#�#� E 44%#�#�#� o  44!���� 0 index80_load_time  #� o  4!4$���� 0 thetype theType#� > 4(44#�#�#� n  4(42#�#�#� 4  4+42��#�
�� 
cobj#� m  4.41���� P#� o  4(4+���� 00 propertiestocolumnsref propertiesToColumnsRef#� m  4243����  #� k  4;4j#�#� #�#�#� r  4;4F#�#�#� n  4;4B#�#�#� 1  4>4B��
�� 
qLTi#� o  4;4>���� 0 thecue theCue#� o      ���� 0 thetime theTime#� #�#�#� r  4G4S#�#�#� n 4G4O#�#�#� I  4H4O��#����� 0 makehhmmsssss makeHHMMSSsss#� #���#� o  4H4K���� 0 thetime theTime��  ��  #�  f  4G4H#� o      ���� 0 theitem theItem#� #���#� r  4T4j#�#�#� o  4T4W���� 0 theitem theItem#� n      #�#�#� 4  4Z4i��#�
�� 
cobj#� l 4]4h#�����#� n  4]4h#�#�#� 4  4`4g��#�
�� 
cobj#� m  4c4f���� P#� o  4]4`���� 00 propertiestocolumnsref propertiesToColumnsRef��  ��  #� o  4W4Z���� $0 thepropertiesref thePropertiesRef��  ��  ��  #� #�#�#� l 4o4o��������  ��  ��  #� #�#�#� Z  4o4�#�#�����#� F  4o4�#�#�#� E 4o4v#�#�#� o  4o4r���� 0 index81_assigned_number  #� o  4r4u���� 0 thetype theType#� > 4y4�#�#�#� n  4y4�#�#�#� 4  4|4���#�
�� 
cobj#� m  44����� Q#� o  4y4|���� 00 propertiestocolumnsref propertiesToColumnsRef#� m  4�4�����  #� k  4�4�#�#� #�#�#� r  4�4�#�#�#� c  4�4�#�#�#� n  4�4�#�#�#� 1  4�4���
�� 
qASN#� o  4�4����� 0 thecue theCue#� m  4�4���
�� 
TEXT#� o      �� 0 theitem theItem#� #��#� r  4�4�#�#�#� o  4�4��� 0 theitem theItem#� n      #�#�#� 4  4�4��#�
� 
cobj#� l 4�4�#���#� n  4�4�#�#�#� 4  4�4��#�
� 
cobj#� m  4�4��� Q#� o  4�4��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  #� o  4�4��� $0 thepropertiesref thePropertiesRef�  ��  ��  #� #�#�#� l 4�4�����  �  �  #� $ $$  Z  4�51$$��$ > 4�4�$$$ n  4�4�$$$ 4  4�4��$
� 
cobj$ m  4�4��� R$ o  4�4��� 00 propertiestocolumnsref propertiesToColumnsRef$ m  4�4���  $ l 4�5-$	$
$$	 k  4�5-$$ $$$ r  4�4�$$$ c  4�4�$$$ n  4�4�$$$ 1  4�4��
� 
ID  $ o  4�4��� 0 thecue theCue$ m  4�4��
� 
TEXT$ o      �� 0 thiscue thisCue$ $$$ l 4�4�$$$$ r  4�4�$$$ o  4�4��� *0 cuelistsnotingroups cuelistsNotInGroups$ o      �� 0 theitem theItem$ R L Hopefully only cue lists will not have this variable reset by the next step   $ �$$ �   H o p e f u l l y   o n l y   c u e   l i s t s   w i l l   n o t   h a v e   t h i s   v a r i a b l e   r e s e t   b y   t h e   n e x t   s t e p$ $$$ Y  4�5$�$ $!$"$ Z  4�5$#$$��$# = 4�4�$%$&$% o  4�4��� 0 thiscue thisCue$& n  4�4�$'$($' 4  4�4��$)
� 
cobj$) o  4�4��� 0 j  $( o  4�4��� (0 groupmembershipref groupMembershipRef$$ k  4�5$*$* $+$,$+ r  4�5$-$.$- n  4�5$/$0$/ 4  5 5�$1
� 
cobj$1 l 55$2��$2 [  55$3$4$3 o  55�� 0 j  $4 m  55�� �  �  $0 o  4�5 �� (0 groupmembershipref groupMembershipRef$. o      �� 0 theitem theItem$, $5�$5  S  55�  �  �  � 0 j  $  m  4�4��� $! I 4�4��$6�
� .corecnte****       ****$6 o  4�4��� (0 groupmembershipref groupMembershipRef�  $" m  4�4��� $ $7�$7 r  55-$8$9$8 o  55�� 0 theitem theItem$9 n      $:$;$: 4  55,�$<
� 
cobj$< l 5 5+$=��$= n  5 5+$>$?$> 4  5#5*�$@
� 
cobj$@ m  5&5)�� R$? o  5 5#�� 00 propertiestocolumnsref propertiesToColumnsRef�  �  $; o  55�� $0 thepropertiesref thePropertiesRef�  $
 * $ Identify which group this cue is in   $ �$A$A H   I d e n t i f y   w h i c h   g r o u p   t h i s   c u e   i s   i n�  �  $ $B$C$B l 5252����  �  �  $C $D$E$D Z  525k$F$G��$F > 525>$H$I$H n  525<$J$K$J 4  555<�$L
� 
cobj$L m  585;�� S$K o  5255�� 00 propertiestocolumnsref propertiesToColumnsRef$I m  5<5=��  $G l 5A5g$M$N$O$M k  5A5g$P$P $Q$R$Q r  5A5P$S$T$S c  5A5L$U$V$U n  5A5H$W$X$W 1  5D5H�
� 
ID  $X o  5A5D�� 0 thecue theCue$V m  5H5K�~
�~ 
TEXT$T o      �}�} 0 theitem theItem$R $Y�|$Y r  5Q5g$Z$[$Z o  5Q5T�{�{ 0 theitem theItem$[ n      $\$]$\ 4  5W5f�z$^
�z 
cobj$^ l 5Z5e$_�y�x$_ n  5Z5e$`$a$` 4  5]5d�w$b
�w 
cobj$b m  5`5c�v�v S$a o  5Z5]�u�u 00 propertiestocolumnsref propertiesToColumnsRef�y  �x  $] o  5T5W�t�t $0 thepropertiesref thePropertiesRef�|  $N   index83_unique   $O �$c$c    i n d e x 8 3 _ u n i q u e�  �  $E $d$e$d l 5l5l�s�r�q�s  �r  �q  $e $f$g$f Z  5l5�$h$i�p�o$h > 5l5x$j$k$j n  5l5v$l$m$l 4  5o5v�n$n
�n 
cobj$n m  5r5u�m�m T$m o  5l5o�l�l 00 propertiestocolumnsref propertiesToColumnsRef$k m  5v5w�k�k  $i l 5{5�$o$p$q$o k  5{5�$r$r $s$t$s r  5{5�$u$v$u n  5{5�$w$x$w 1  5~5��j
�j 
qBrk$x o  5{5~�i�i 0 thecue theCue$v o      �h�h 0 theitem theItem$t $y�g$y Z  5�5�$z${$|�f$z = 5�5�$}$~$} o  5�5��e�e 0 theitem theItem$~ m  5�5��d
�d boovtrue${ r  5�5�$$�$ n  5�5�$�$�$� 4  5�5��c$�
�c 
cobj$� m  5�5��b�b $� o  5�5��a�a 0 constants84_broken  $� n      $�$�$� 4  5�5��`$�
�` 
cobj$� l 5�5�$��_�^$� n  5�5�$�$�$� 4  5�5��]$�
�] 
cobj$� m  5�5��\�\ T$� o  5�5��[�[ 00 propertiestocolumnsref propertiesToColumnsRef�_  �^  $� o  5�5��Z�Z $0 thepropertiesref thePropertiesRef$| $�$�$� = 5�5�$�$�$� o  5�5��Y�Y 0 theitem theItem$� m  5�5��X
�X boovfals$� $��W$� r  5�5�$�$�$� n  5�5�$�$�$� 4  5�5��V$�
�V 
cobj$� m  5�5��U�U $� o  5�5��T�T 0 constants84_broken  $� n      $�$�$� 4  5�5��S$�
�S 
cobj$� l 5�5�$��R�Q$� n  5�5�$�$�$� 4  5�5��P$�
�P 
cobj$� m  5�5��O�O T$� o  5�5��N�N 00 propertiestocolumnsref propertiesToColumnsRef�R  �Q  $� o  5�5��M�M $0 thepropertiesref thePropertiesRef�W  �f  �g  $p   index84_broken   $q �$�$�    i n d e x 8 4 _ b r o k e n�p  �o  $g $�$�$� l 5�5��L�K�J�L  �K  �J  $� $�$�$� Z  5�6 $�$��I�H$� F  5�5�$�$�$� E 5�5�$�$�$� o  5�5��G�G  0 index85_audio_input_channels  $� o  5�5��F�F 0 thetype theType$� > 5�5�$�$�$� n  5�5�$�$�$� 4  5�5��E$�
�E 
cobj$� m  5�5��D�D U$� o  5�5��C�C 00 propertiestocolumnsref propertiesToColumnsRef$� m  5�5��B�B  $� l 5�6$�$�$�$� k  5�6$�$� $�$�$� r  5�6$�$�$� c  5�6$�$�$� n  5�5�$�$�$� 1  5�5��A
�A 
qNCh$� o  5�5��@�@ 0 thecue theCue$� m  5�6 �?
�? 
TEXT$� o      �>�> 0 theitem theItem$� $��=$� r  66$�$�$� o  66	�<�< 0 theitem theItem$� n      $�$�$� 4  66�;$�
�; 
cobj$� l 66$��:�9$� n  66$�$�$� 4  66�8$�
�8 
cobj$� m  66�7�7 U$� o  66�6�6 00 propertiestocolumnsref propertiesToColumnsRef�:  �9  $� o  6	6�5�5 $0 thepropertiesref thePropertiesRef�=  $� #  index85_audio_input_channels   $� �$�$� :   i n d e x 8 5 _ a u d i o _ i n p u t _ c h a n n e l s�I  �H  $� $�$�$� l 6!6!�4�3�2�4  �3  �2  $� $�$�$� Z  6!6�$�$��1�0$� F  6!6;$�$�$� E 6!6($�$�$� o  6!6$�/�/ 0 index86_start_value  $� o  6$6'�.�. 0 thetype theType$� > 6+67$�$�$� n  6+65$�$�$� 4  6.65�-$�
�- 
cobj$� m  6164�,�, V$� o  6+6.�+�+ 00 propertiestocolumnsref propertiesToColumnsRef$� m  6566�*�*  $� k  6>6�$�$� $�$�$� Z  6>6q$�$��)$�$� > 6>6I$�$�$� n  6>6E$�$�$� 1  6A6E�(
�( 
qCOm$� o  6>6A�'�' 0 thecue theCue$� m  6E6H�&
�& MICOPiBe$� r  6L6[$�$�$� c  6L6W$�$�$� n  6L6S$�$�$� 1  6O6S�%
�% 
qSVA$� o  6L6O�$�$ 0 thecue theCue$� m  6S6V�#
�# 
TEXT$� o      �"�" 0 theitem theItem�)  $� l 6^6q$�$�$�$� r  6^6q$�$�$� c  6^6m$�$�$� l 6^6i$��!� $� \  6^6i$�$�$� l 6^6e$���$� n  6^6e$�$�$� 1  6a6e�
� 
qSVA$� o  6^6a�� 0 thecue theCue�  �  $� m  6e6h��  �!  �   $� m  6i6l�
� 
TEXT$� o      �� 0 theitem theItem$� H B No need to protect against trying to subract from "missing value"   $� �$�$� �   N o   n e e d   t o   p r o t e c t   a g a i n s t   t r y i n g   t o   s u b r a c t   f r o m   " m i s s i n g   v a l u e "$� $��$� Z  6r6�$�$���$� > 6r6y$�$�$� o  6r6u�� 0 theitem theItem$� m  6u6x$�$� �$�$�  m i s s i n g   v a l u e$� r  6|6�$�$�$� o  6|6�� 0 theitem theItem$� n      $�$�$� 4  6�6��$�
� 
cobj$� l 6�6�$���$� n  6�6�$�$�$� 4  6�6��$�
� 
cobj$� m  6�6��� V$� o  6�6��� 00 propertiestocolumnsref propertiesToColumnsRef�  �  $� o  66��� $0 thepropertiesref thePropertiesRef�  �  �  �1  �0  $� % %%  l 6�6����
�  �  �
  % %%% Z  6�7�%%�	�% E 6�6�%%% o  6�6���  0 index_setlevel index_setLevel% o  6�6��� 0 thetype theType% k  6�7�%% %	%
%	 Z  6�6�%%�%% > 6�6�%%% o  6�6��� 0 thetype theType% m  6�6�%% �%%  F a d e% l 6�6�%%%% r  6�6�%%% n  6�6�%%% 1  6�6��
� 
qNCh% o  6�6��� 0 thecue theCue% o      �� 0 audiochannels audioChannels% F @ This bit stops the script from reporting rows that aren't valid   % �%% �   T h i s   b i t   s t o p s   t h e   s c r i p t   f r o m   r e p o r t i n g   r o w s   t h a t   a r e n ' t   v a l i d�  % Z  6�6�%%� %% = 6�6�%%% n  6�6�%% % 1  6�6���
�� 
qBrk%  o  6�6����� 0 thecue theCue% m  6�6���
�� boovfals% Q  6�6�%!%"%#%! l 6�6�%$%%%&%$ r  6�6�%'%(%' n  6�6�%)%*%) 1  6�6���
�� 
qNCh%* n  6�6�%+%,%+ 1  6�6���
�� 
qQTr%, o  6�6����� 0 thecue theCue%( o      ���� 0 audiochannels audioChannels%% = 7 This protects against the cue target being a Group Cue   %& �%-%- n   T h i s   p r o t e c t s   a g a i n s t   t h e   c u e   t a r g e t   b e i n g   a   G r o u p   C u e%" R      ������
�� .ascrerr ****      � ****��  ��  %# r  6�6�%.%/%. m  6�6����� %/ o      ���� 0 audiochannels audioChannels�   % r  6�6�%0%1%0 m  6�6����� %1 o      ���� 0 audiochannels audioChannels%
 %2%3%2 X  6�7�%4��%5%4 k  77�%6%6 %7%8%7 r  77%9%:%9 m  77%;%; �%<%<  "%: n     %=%>%= 1  77��
�� 
txdl%> 1  77��
�� 
ascr%8 %?%@%? l 77$%A%B%C%A r  77$%D%E%D n  77 %F%G%F 4  77 ��%H
�� 
cwor%H m  77���� %G n  77%I%J%I 4  77��%K
�� 
cobj%K o  77���� "0 eachlevelcolumn eachLevelColumn%J o  77���� 0 	headerrow 	headerRow%E o      ���� 0 excelcleanup excelCleanup%B B < Deal with Excel formatting: 0,0 becomes "0,0" when exported   %C �%L%L x   D e a l   w i t h   E x c e l   f o r m a t t i n g :   0 , 0   b e c o m e s   " 0 , 0 "   w h e n   e x p o r t e d%@ %M%N%M r  7%7,%O%P%O m  7%7(%Q%Q �%R%R  ,%P n     %S%T%S 1  7)7+��
�� 
txdl%T 1  7(7)��
�� 
ascr%N %U%V%U r  7-7=%W%X%W c  7-79%Y%Z%Y n  7-75%[%\%[ 4  7075��%]
�� 
citm%] m  7374���� %\ o  7-70���� 0 excelcleanup excelCleanup%Z m  7578��
�� 
long%X o      ���� 0 therow theRow%V %^%_%^ Z  7>7�%`%a��%b%` ? 7>7E%c%d%c o  7>7A���� 0 therow theRow%d o  7A7D���� 0 audiochannels audioChannels%a r  7H7O%e%f%e o  7H7K���� .0 irrelevantcrosspoints irrelevantCrosspoints%f o      ���� 0 thelevel theLevel��  %b k  7R7�%g%g %h%i%h r  7R7b%j%k%j c  7R7^%l%m%l n  7R7Z%n%o%n 4  7U7Z��%p
�� 
citm%p m  7X7Y���� %o o  7R7U���� 0 excelcleanup excelCleanup%m m  7Z7]��
�� 
long%k o      ���� 0 	thecolumn 	theColumn%i %q%r%q r  7c7�%s%t%s I 7c7|��%u%v
�� .QLablevgnull���     aCue%u o  7c7f���� 0 thecue theCue%v ��%w%x
�� 
levR%w o  7i7l���� 0 therow theRow%x ��%y��
�� 
levC%y c  7o7v%z%{%z o  7o7r���� 0 	thecolumn 	theColumn%{ m  7r7u��
�� 
nmbr��  %t o      ���� 0 thelevel theLevel%r %|��%| Z  7�7�%}%~����%} B  7�7�%%�% o  7�7����� 0 thelevel theLevel%� n  7�7�%�%�%� 4  7�7���%�
�� 
cobj%� m  7�7����� %� o  7�7����� 0 minusinfinity minusInfinity%~ r  7�7�%�%�%� n  7�7�%�%�%� 4  7�7���%�
�� 
cobj%� m  7�7����� %� o  7�7����� 0 minusinfinity minusInfinity%� o      ���� 0 thelevel theLevel��  ��  ��  %_ %���%� r  7�7�%�%�%� o  7�7����� 0 thelevel theLevel%� n      %�%�%� 4  7�7���%�
�� 
cobj%� o  7�7����� "0 eachlevelcolumn eachLevelColumn%� o  7�7��� $0 thepropertiesref thePropertiesRef��  �� "0 eachlevelcolumn eachLevelColumn%5 o  6�6��� 0 levelcolumns levelColumns%3 %��%� r  7�7�%�%�%� 1  7�7��
� 
tab %� n     %�%�%� 1  7�7��
� 
txdl%� 1  7�7��
� 
ascr�  �	  �  % %�%�%� l 7�7�����  �  �  %� %�%�%� l 7�7��%�%��  %� 1 + Add thePropertiesRef to the end of theText   %� �%�%� V   A d d   t h e P r o p e r t i e s R e f   t o   t h e   e n d   o f   t h e T e x t%� %�%�%� l 7�7�����  �  �  %� %�%�%� r  7�7�%�%�%� c  7�7�%�%�%� b  7�7�%�%�%� b  7�7�%�%�%� o  7�7��� 0 thetext theText%� o  7�7��
� 
ret %� o  7�7��� $0 thepropertiesref thePropertiesRef%� m  7�7��
� 
TEXT%� o      �� 0 thetext theText%� %�%�%� l 7�7�����  �  �  %� %�%�%� l 7�7��%�%��  %� 2 , Countdown timer (and opportunity to escape)   %� �%�%� X   C o u n t d o w n   t i m e r   ( a n d   o p p o r t u n i t y   t o   e s c a p e )%� %�%�%� l 7�7�����  �  �  %� %�%�%� Z  7�8n%�%���%� F  7�7�%�%�%� = 7�7�%�%�%� `  7�7�%�%�%� o  7�7��� 0 i  %� m  7�7��� 
%� m  7�7���  %� ?  7�7�%�%�%� l 7�7�%���%� \  7�7�%�%�%� o  7�7��� 0 	countcues 	countCues%� o  7�7��� 0 i  �  �  %� m  7�7��� %� Z  7�8j%�%���%� = 7�7�%�%�%� n  7�7�%�%�%� 1  7�7��
� 
pisf%� m  7�7�%�%��                                                                                      @ alis    h  Macintosh HD               Ѳ(�H+   
��
QLab 3.app                                                      �)�֝�P        ����  	                	Downloads     Ѳ�      ֝�P     
�� 
�� �9  .Macintosh HD:Users: cmg: Downloads: QLab 3.app   
 Q L a b   3 . a p p    M a c i n t o s h   H D  Users/cmg/Downloads/QLab 3.app  /    
��  %� m  7�7��
� boovtrue%� k  7�8f%�%� %�%�%� r  7�8%�%�%� c  7�8
%�%�%� l 7�8%���%� \  7�8%�%�%� l 7�8%���%� n  7�8%�%�%� 1  7�8�
� 
aSlt%� l 7�7�%���%� I 7�7����
� .misccurdldt    ��� null�  �  �  �  �  �  %� o  88�� 0 	starttime 	startTime�  �  %� m  88	�
� 
long%� o      �� 0 	timetaken 	timeTaken%� %�%�%� r  88%�%�%� n 88%�%�%� I  88�%��� 0 makemmss makeMMSS%� %��%� o  88�� 0 	timetaken 	timeTaken�  �  %�  f  88%� o      �� 0 
timestring 
timeString%� %��%� I 88f�%�%�
� .sysodlogaskr        TEXT%� b  88=%�%�%� l 889%���%� c  889%�%�%� b  885%�%�%� b  881%�%�%� l 88-%���%� c  88-%�%�%� b  88)%�%�%� b  88'%�%�%� b  88#%�%�%� m  88%�%� �%�%�  T i m e   e l a p s e d :  %� o  88"�� 0 
timestring 
timeString%� m  8#8&%�%� �%�%�    -  %� o  8'8(�� 0 i  %� m  8)8,�~
�~ 
TEXT�  �  %� m  8-80%�%� �%�%�    o f  %� o  8184�}�} 0 	countcues 	countCues%� m  8588�|
�| 
TEXT�  �  %� m  898<%�%� �%�%�    c u e s   d o n e . . .%� �{%�%�
�{ 
appr%� l 	8@8A%��z�y%� o  8@8A�x�x 0 dialogtitle dialogTitle�z  �y  %� �w%�%�
�w 
disp%� m  8D8E�v�v %� �u%�%�
�u 
btns%� J  8H8P& &  &&& m  8H8K&& �&&  C a n c e l& &�t& m  8K8N&& �&&  O K�t  %� �s&&	
�s 
dflt& m  8S8V&
&
 �&&  O K&	 �r&&
�r 
cbtn& m  8Y8\&& �&&  C a n c e l& �q&�p
�q 
givu& m  8_8`�o�o �p  �  �  �  �  �  %� &�n& l 8o8o�m�l�k�m  �l  �k  �n  �� 0 i  � m  �j�j � o  �i�i 0 	countcues 	countCues��  � &�h& l 8v8v�g�f�e�g  �f  �e  �h  � 4 ���d&
�d 
qDoc& m  ���c�c � &�b& l 8y8y�a�`�_�a  �`  �_  �b  � m  ]`&&�                                                                                      @ alis    h  Macintosh HD               Ѳ(�H+   
��
QLab 3.app                                                      �)�֝�P        ����  	                	Downloads     Ѳ�      ֝�P     
�� 
�� �9  .Macintosh HD:Users: cmg: Downloads: QLab 3.app   
 Q L a b   3 . a p p    M a c i n t o s h   H D  Users/cmg/Downloads/QLab 3.app  /    
��  � &&& l 8|8|�^�]�\�^  �]  �\  & &&& l 8|8|�[&&�[  & * $ Write the text back out to the file   & �&& H   W r i t e   t h e   t e x t   b a c k   o u t   t o   t h e   f i l e& &&& l 8|8|�Z�Y�X�Z  �Y  �X  & && & I 8|8��W&!&"
�W .rdwrwritnull���     ****&! o  8|8�V�V 0 thetext theText&" �U&#�T
�U 
refn&# o  8�8��S�S 0 theopenfile theOpenFile�T  &  &$&%&$ I 8�8��R&&�Q
�R .rdwrclosnull���     ****&& o  8�8��P�P 0 theopenfile theOpenFile�Q  &% &'&(&' l 8�8��O�N�M�O  �N  �M  &( &)&*&) l 8�8��L&+&,�L  &+   All done. Hoopla!   &, �&-&- $   A l l   d o n e .   H o o p l a !&* &.&/&. l 8�8��K�J�I�K  �J  �I  &/ &0&1&0 O  8�9&2&3&2 k  8�9&4&4 &5&6&5 r  8�8�&7&8&7 c  8�8�&9&:&9 l 8�8�&;�H�G&; \  8�8�&<&=&< l 8�8�&>�F�E&> n  8�8�&?&@&? 1  8�8��D
�D 
aSlt&@ l 8�8�&A�C�B&A I 8�8��A�@�?
�A .misccurdldt    ��� null�@  �?  �C  �B  �F  �E  &= o  8�8��>�> 0 	starttime 	startTime�H  �G  &: m  8�8��=
�= 
long&8 o      �<�< 0 	timetaken 	timeTaken&6 &B&C&B r  8�8�&D&E&D n 8�8�&F&G&F I  8�8��;&H�:�; 0 	makenicet 	makeNiceT&H &I�9&I o  8�8��8�8 0 	timetaken 	timeTaken�9  �:  &G  f  8�8�&E o      �7�7 0 
timestring 
timeString&C &J&K&J I 8�8��6�5�4
�6 .miscactvnull��� ��� null�5  �4  &K &L&M&L l 8�8�&N&O&P&N r  8�8�&Q&R&Q m  8�8�&S&S �&T&T  &R o      �3�3 0 whatnext whatNext&O   In case dialog gives up   &P �&U&U 0   I n   c a s e   d i a l o g   g i v e s   u p&M &V�2&V r  8�9&W&X&W n  8�9 &Y&Z&Y 1  8�9 �1
�1 
bhit&Z l 8�8�&[�0�/&[ I 8�8��.&\&]
�. .sysodlogaskr        TEXT&\ b  8�8�&^&_&^ b  8�8�&`&a&` m  8�8�&b&b �&c&c ( D o n e .   
   
 ( T h a t   t o o k  &a o  8�8��-�- 0 
timestring 
timeString&_ m  8�8�&d&d �&e&e  . )&] �,&f&g
�, 
appr&f o  8�8��+�+ 0 dialogtitle dialogTitle&g �*&h&i
�* 
disp&h l 
8�8�&j�)�(&j m  8�8��'�' �)  �(  &i �&&k&l
�& 
btns&k J  8�8�&m&m &n&o&n m  8�8�&p&p �&q&q  O p e n   i n   E x c e l&o &r&s&r m  8�8�&t&t �&u&u   O p e n   i n   T e x t E d i t&s &v�%&v m  8�8�&w&w �&x&x   R e v e a l   i n   F i n d e r�%  &l �$&y&z
�$ 
dflt&y m  8�8�&{&{ �&|&|   R e v e a l   i n   F i n d e r&z �#&}�"
�# 
givu&} m  8�8��!�! <�"  �0  �/  &X o      � �  0 whatnext whatNext�2  &3 m  8�8�&~&~�                                                                                      @ alis    h  Macintosh HD               Ѳ(�H+   
��
QLab 3.app                                                      �)�֝�P        ����  	                	Downloads     Ѳ�      ֝�P     
�� 
�� �9  .Macintosh HD:Users: cmg: Downloads: QLab 3.app   
 Q L a b   3 . a p p    M a c i n t o s h   H D  Users/cmg/Downloads/QLab 3.app  /    
��  &1 &&�& l 99����  �  �  &� &�&�&� r  99&�&�&� o  99�� 0 currenttids currentTIDs&� n     &�&�&� 1  99
�
� 
txdl&� 1  99�
� 
ascr&� &�&�&� l 99����  �  �  &� &�&�&� Z  99�&�&�&�&�&� = 99&�&�&� o  99�� 0 whatnext whatNext&� m  99&�&� �&�&�  O p e n   i n   E x c e l&� Q  99�&�&�&�&� O  99e&�&�&� k  99d&�&� &�&�&� r  99%&�&�&� J  99!��  &� o      �� ,0 openallcolumnsastext openAllColumnsAsText&� &�&�&� Y  9&9F&��&�&��&� s  969A&�&�&� J  969<&�&� &�&�&� o  9697�� 0 i  &� &��&� m  979:�
� e249� �  &� n      &�&�&�  ;  9?9@&� o  9<9?�� ,0 openallcolumnsastext openAllColumnsAsText� 0 i  &� m  9)9*�� &� I 9*91�&��
� .corecnte****       ****&� o  9*9-�
�
 0 	headerrow 	headerRow�  �  &� &�&�&� I 9G9L�	��
�	 .miscactvnull��� ��� null�  �  &� &��&� I 9M9d��&�
� .smXLXoTxnull��� ��� null�  &� �&�&�
� 
5016&� o  9Q9T�� 0 newfile newFile&� �&�&�
� 
5225&� o  9W9Z� �  ,0 openallcolumnsastext openAllColumnsAsText&� ��&���
�� 
5219&� m  9]9^��
�� boovtrue��  �  &� m  99&�&�
                                                                                  XCEL  alis    �  Macintosh HD               Ѳ(�H+   ��Microsoft Excel.app                                             χȚ�E        ����  	                Microsoft Office 2011     Ѳ�      Ț�5     �� 8�]  EMacintosh HD:Applications: Microsoft Office 2011: Microsoft Excel.app   (  M i c r o s o f t   E x c e l . a p p    M a c i n t o s h   H D  6Applications/Microsoft Office 2011/Microsoft Excel.app  / ��  &� R      ������
�� .ascrerr ****      � ****��  ��  &� I 9m9���&�&�
�� .sysodlogaskr        TEXT&� m  9m9p&�&� �&�&� F T h a t   d i d n ' t   w o r k   f o r   s o m e   r e a s o n . . .&� ��&�&�
�� 
appr&� o  9s9t���� 0 dialogtitle dialogTitle&� ��&�&�
�� 
disp&� m  9w9x����  &� ��&�&�
�� 
btns&� J  9{9�&�&� &���&� m  9{9~&�&� �&�&�  O K��  &� ��&���
�� 
dflt&� m  9�9�&�&� �&�&�  O K��  &� &�&�&� = 9�9�&�&�&� o  9�9����� 0 whatnext whatNext&� m  9�9�&�&� �&�&�   O p e n   i n   T e x t E d i t&� &���&� Q  9�9�&�&�&�&� O  9�9�&�&�&� k  9�9�&�&� &�&�&� I 9�9�������
�� .miscactvnull��� ��� null��  ��  &� &�&�&� I 9�9���&���
�� .aevtodocnull  �    alis&� o  9�9����� 0 newfile newFile��  &� &���&� r  9�9�&�&�&� m  9�9���
�� boovtrue&� n      &�&�&� 1  9�9���
�� 
pzum&� 4 9�9���&�
�� 
cwin&� m  9�9����� ��  &� m  9�9�&�&��                                                                                  ttxt  alis    V  Macintosh HD               Ѳ(�H+   8�]TextEdit.app                                                    9�x��s        ����  	                Applications    Ѳ�      ��d�     8�]  'Macintosh HD:Applications: TextEdit.app     T e x t E d i t . a p p    M a c i n t o s h   H D  Applications/TextEdit.app   / ��  &� R      ������
�� .ascrerr ****      � ****��  ��  &� I 9�9���&�&�
�� .sysodlogaskr        TEXT&� m  9�9�&�&� �&�&� F T h a t   d i d n ' t   w o r k   f o r   s o m e   r e a s o n . . .&� ��&�&�
�� 
appr&� o  9�9����� 0 dialogtitle dialogTitle&� ��&�&�
�� 
disp&� m  9�9�����  &� ��&�&�
�� 
btns&� J  9�9�&�&� &���&� m  9�9�&�&� �&�&�  O K��  &� ��&���
�� 
dflt&� m  9�9�&�&� �&�&�  O K��  ��  &� O  9�9�&�&�&� I 9�9���&���
�� .miscmvisnull���    obj &� o  9�9����� 0 newfile newFile��  &� m  9�9�&�&��                                                                                  MACS  alis    t  Macintosh HD               Ѳ(�H+   8�=
Finder.app                                                      ;�_��o�        ����  	                CoreServices    Ѳ�      ��o�     8�= 8�< 8�;  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  &� &���&� l 9�9���������  ��  ��  ��   R L This overall try makes sure TIDs are reset if any "Cancel" button is pushed    �&�&� �   T h i s   o v e r a l l   t r y   m a k e s   s u r e   T I D s   a r e   r e s e t   i f   a n y   " C a n c e l "   b u t t o n   i s   p u s h e d R      ����&�
�� .ascrerr ****      � ****��  &� ��&���
�� 
errn&� d      &�&� m      ���� ���   k  9�:g&�&� &�&�&� r  9�:&�&�&� o  9�: ���� 0 currenttids currentTIDs&� n     &�&�&� 1  ::��
�� 
txdl&� 1  : :��
�� 
ascr&� ' ��'  Z  ::g''����' = ::
''' o  ::���� 0 filemade fileMade' m  ::	��
�� boovtrue' k  ::c'' ''' I ::,��''	
�� .sysodlogaskr        TEXT' m  ::'
'
 �'' � Y o u ' v e   c a n c e l l e d   t o o   l a t e   i n   t h e   p r o c e s s   t o   s t o p   m e   m a k i n g   a   f i l e ,   b u t   h e r e   i t   i s   f o r   y o u   t o   d i s p o s e   o f . . .'	 ��''
�� 
appr' l 	::'����' o  ::���� 0 dialogtitle dialogTitle��  ��  ' ��''
�� 
disp' m  ::����  ' ��''
�� 
btns' J  :: '' '��' m  ::'' �''   R e v e a l   i n   F i n d e r��  ' ��'��
�� 
dflt' m  :#:&'' �''   R e v e a l   i n   F i n d e r��  ' ''' Q  :-:N''��' k  :0:E'' '' ' I :0:=��'!'"
�� .rdwrwritnull���     ****'! o  :0:3���� 0 thetext theText'" ��'#��
�� 
refn'# o  :6:9���� 0 theopenfile theOpenFile��  '  '$��'$ I :>:E��'%��
�� .rdwrclosnull���     ****'% o  :>:A���� 0 theopenfile theOpenFile��  ��  ' R      ������
�� .ascrerr ****      � ****��  ��  ��  ' '&��'& O  :O:c'''('' k  :U:b')') '*'+'* I :U:\��',��
�� .miscmvisnull���    obj ', o  :U:X���� 0 newfile newFile��  '+ '-��'- I :]:b������
�� .miscactvnull��� ��� null��  ��  ��  '( m  :O:R'.'.�                                                                                  MACS  alis    t  Macintosh HD               Ѳ(�H+   8�=
Finder.app                                                      ;�_��o�        ����  	                CoreServices    Ѳ�      ��o�     8�= 8�< 8�;  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��  ��  ��  ��  ��   '/'0'/ l     ��������  ��  ��  '0 '1'2'1 l     ��'3'4��  '3   Subroutines   '4 �'5'5    S u b r o u t i n e s'2 '6'7'6 l     ����  �  �  '7 '8'9'8 i     ':';': I      �'<��  0 totheclipboard toTheClipboard'< '=�'= o      �� 0 
texttocopy 
textToCopy�  �  '; k     '>'> '?'@'? r     'A'B'A 1     �
� 
tab 'B n     'C'D'C 1    �
� 
txdl'D 1    �
� 
ascr'@ 'E'F'E I   �'G�
� .JonspClpnull���     ****'G c    	'H'I'H o    �� 0 
texttocopy 
textToCopy'I m    �
� 
ctxt�  'F 'J�'J r    'K'L'K o    �� 0 currenttids currentTIDs'L n     'M'N'M 1    �
� 
txdl'N 1    �
� 
ascr�  '9 'O'P'O l     ����  �  �  'P 'Q'R'Q i    'S'T'S I      ���� 0 exitstrategy exitStrategy�  �  'T k     'U'U 'V'W'V I    �'X'Y
� .sysodlogaskr        TEXT'X m     'Z'Z �'['[ � I ' m   a f r a i d   t h a t   f i l e   t a s t e d   f u n n y   s o   I ' v e   h a d   t o   s p i t   i t   o u t .   P l e a s e   c h e c k   t h e   f i l e   a n d   t r y   a g a i n .   S o r r y .'Y �'\']
� 
appr'\ l 	  '^��'^ o    �� 0 dialogtitle dialogTitle�  �  '] �'_'`
� 
disp'_ m    ��  '` �'a'b
� 
btns'a J    	'c'c 'd�'d m    'e'e �'f'f  O K�  'b �~'g�}
�~ 
dflt'g m   
 'h'h �'i'i  O K�}  'W 'j�|'j r    'k'l'k o    �{�{ 0 currenttids currentTIDs'l n     'm'n'm 1    �z
�z 
txdl'n 1    �y
�y 
ascr�|  'R 'o'p'o l     �x�w�v�x  �w  �v  'p 'q'r'q i    's't's I      �u'u�t�u 0 	makenicet 	makeNiceT'u 'v�s'v o      �r�r 0 howlong howLong�s  �t  't k     �'w'w 'x'y'x Z     'z'{�q�p'z =    '|'}'| o     �o�o 0 howlong howLong'} m    �n�n  '{ L    '~'~ m    '' �'�'� $ l e s s   t h a n   a   s e c o n d�q  �p  'y '�'�'� r    '�'�'� _    '�'�'� o    �m�m 0 howlong howLong'� m    �l�l'� o      �k�k 0 howmanyhours howManyHours'� '�'�'� Z    2'�'�'�'�'� =   '�'�'� o    �j�j 0 howmanyhours howManyHours'� m    �i�i  '� r    '�'�'� m    '�'� �'�'�  '� o      �h�h 0 
hourstring 
hourString'� '�'�'� =   "'�'�'� o     �g�g 0 howmanyhours howManyHours'� m     !�f�f '� '��e'� r   % ('�'�'� m   % &'�'� �'�'�  1   h o u r'� o      �d�d 0 
hourstring 
hourString�e  '� r   + 2'�'�'� b   + 0'�'�'� l  + .'��c�b'� c   + .'�'�'� o   + ,�a�a 0 howmanyhours howManyHours'� m   , -�`
�` 
TEXT�c  �b  '� m   . /'�'� �'�'�    h o u r s'� o      �_�_ 0 
hourstring 
hourString'� '�'�'� r   3 :'�'�'� _   3 8'�'�'� l  3 6'��^�]'� `   3 6'�'�'� o   3 4�\�\ 0 howlong howLong'� m   4 5�[�[�^  �]  '� m   6 7�Z�Z <'� o      �Y�Y  0 howmanyminutes howManyMinutes'� '�'�'� Z   ; Z'�'�'�'�'� =  ; >'�'�'� o   ; <�X�X  0 howmanyminutes howManyMinutes'� m   < =�W�W  '� r   A D'�'�'� m   A B'�'� �'�'�  '� o      �V�V 0 minutestring minuteString'� '�'�'� =  G J'�'�'� o   G H�U�U  0 howmanyminutes howManyMinutes'� m   H I�T�T '� '��S'� r   M P'�'�'� m   M N'�'� �'�'�  1   m i n u t e'� o      �R�R 0 minutestring minuteString�S  '� r   S Z'�'�'� b   S X'�'�'� l  S V'��Q�P'� c   S V'�'�'� o   S T�O�O  0 howmanyminutes howManyMinutes'� m   T U�N
�N 
TEXT�Q  �P  '� m   V W'�'� �'�'�    m i n u t e s'� o      �M�M 0 minutestring minuteString'� '�'�'� r   [ b'�'�'� c   [ `'�'�'� `   [ ^'�'�'� o   [ \�L�L 0 howlong howLong'� m   \ ]�K�K <'� m   ^ _�J
�J 
long'� o      �I�I  0 howmanyseconds howManySeconds'� '�'�'� Z   c �'�'�'�'�'� =  c f'�'�'� o   c d�H�H  0 howmanyseconds howManySeconds'� m   d e�G�G  '� r   i l'�'�'� m   i j'�'� �'�'�  '� o      �F�F 0 secondstring secondString'� '�'�'� =  o r'�'�'� o   o p�E�E  0 howmanyseconds howManySeconds'� m   p q�D�D '� '��C'� r   u x'�'�'� m   u v'�'� �'�'�  1   s e c o n d'� o      �B�B 0 secondstring secondString�C  '� r   { �'�'�'� b   { �'�'�'� l  { ~'��A�@'� c   { ~'�'�'� o   { |�?�?  0 howmanyseconds howManySeconds'� m   | }�>
�> 
TEXT�A  �@  '� m   ~ '�'� �'�'�    s e c o n d s'� o      �=�= 0 secondstring secondString'� '�'�'� Z   � �'�'��<'�'� >  � �'�'�'� o   � ��;�; 0 
hourstring 
hourString'� m   � �'�'� �'�'�  '� Z   � �'�'�'�'�'� F   � �'�( '� >  � �((( o   � ��:�: 0 minutestring minuteString( m   � �(( �((  (  >  � �((( o   � ��9�9 0 secondstring secondString( m   � �(( �((  '� r   � �(	(
(	 m   � �(( �((  ,  (
 o      �8�8 0 theampersand theAmpersand'� ((( G   � �((( >  � �((( o   � ��7�7 0 minutestring minuteString( m   � �(( �((  ( >  � �((( o   � ��6�6 0 secondstring secondString( m   � �(( �((  ( (�5( r   � �((( m   � �(( �(( 
   a n d  ( o      �4�4 0 theampersand theAmpersand�5  '� r   � �((( m   � �( (  �(!(!  ( o      �3�3 0 theampersand theAmpersand�<  '� r   � �("(#(" m   � �($($ �(%(%  (# o      �2�2 0 theampersand theAmpersand'� (&('(& Z   � �((()�1(*(( F   � �(+(,(+ >  � �(-(.(- o   � ��0�0 0 minutestring minuteString(. m   � �(/(/ �(0(0  (, >  � �(1(2(1 o   � ��/�/ 0 secondstring secondString(2 m   � �(3(3 �(4(4  () r   � �(5(6(5 m   � �(7(7 �(8(8 
   a n d  (6 o      �.�. &0 theotherampersand theOtherAmpersand�1  (* r   � �(9(:(9 m   � �(;(; �(<(<  (: o      �-�- &0 theotherampersand theOtherAmpersand(' (=�,(= L   � �(>(> b   � �(?(@(? b   � �(A(B(A b   � �(C(D(C b   � �(E(F(E o   � ��+�+ 0 
hourstring 
hourString(F o   � ��*�* 0 theampersand theAmpersand(D o   � ��)�) 0 minutestring minuteString(B o   � ��(�( &0 theotherampersand theOtherAmpersand(@ o   � ��'�' 0 secondstring secondString�,  'r (G(H(G l     �&�%�$�&  �%  �$  (H (I(J(I i    (K(L(K I      �#(M�"�# 0 makehhmmssss makeHHMMSSss(M (N�!(N o      � �  0 howlong howLong�!  �"  (L k     �(O(O (P(Q(P r     (R(S(R _     (T(U(T o     �� 0 howlong howLong(U m    ��(S o      �� 0 howmanyhours howManyHours(Q (V(W(V Z    +(X(Y(Z([(X ?    	(\(](\ o    �� 0 howmanyhours howManyHours(] m    �� 	(Y r    (^(_(^ b    (`(a(` l   (b��(b c    (c(d(c o    �� 0 howmanyhours howManyHours(d m    �
� 
TEXT�  �  (a m    (e(e �(f(f  :(_ o      �� 0 
hourstring 
hourString(Z (g(h(g ?    (i(j(i o    �� 0 howmanyhours howManyHours(j m    ��  (h (k�(k r    %(l(m(l b    #(n(o(n b    !(p(q(p m    (r(r �(s(s  0(q l    (t��(t c     (u(v(u o    �� 0 howmanyhours howManyHours(v m    �
� 
TEXT�  �  (o m   ! "(w(w �(x(x  :(m o      �� 0 
hourstring 
hourString�  ([ r   ( +(y(z(y m   ( )({({ �(|(|  (z o      �� 0 
hourstring 
hourString(W (}(~(} r   , 3((�( _   , 1(�(�(� l  , /(���(� `   , /(�(�(� o   , -�
�
 0 howlong howLong(� m   - .�	�	�  �  (� m   / 0�� <(� o      ��  0 howmanyminutes howManyMinutes(~ (�(�(� Z   4 I(�(��(�(� ?   4 7(�(�(� o   4 5��  0 howmanyminutes howManyMinutes(� m   5 6�� 	(� r   : ?(�(�(� l  : =(���(� c   : =(�(�(� o   : ;��  0 howmanyminutes howManyMinutes(� m   ; <� 
�  
TEXT�  �  (� o      ���� 0 minutestring minuteString�  (� r   B I(�(�(� b   B G(�(�(� m   B C(�(� �(�(�  0(� l  C F(�����(� c   C F(�(�(� o   C D����  0 howmanyminutes howManyMinutes(� m   D E��
�� 
TEXT��  ��  (� o      ���� 0 minutestring minuteString(� (�(�(� r   J O(�(�(� `   J M(�(�(� o   J K���� 0 howlong howLong(� m   K L���� <(� o      ����  0 howmanyseconds howManySeconds(� (�(�(� r   P U(�(�(� _   P S(�(�(� o   P Q����  0 howmanyseconds howManySeconds(� m   Q R���� (� o      ���� "0 integralseconds integralSeconds(� (�(�(� Z   V k(�(���(�(� ?   V Y(�(�(� o   V W���� "0 integralseconds integralSeconds(� m   W X���� 	(� r   \ a(�(�(� l  \ _(�����(� c   \ _(�(�(� o   \ ]���� "0 integralseconds integralSeconds(� m   ] ^��
�� 
TEXT��  ��  (� o      ���� 0 secondstring secondString��  (� r   d k(�(�(� b   d i(�(�(� m   d e(�(� �(�(�  0(� l  e h(�����(� c   e h(�(�(� o   e f���� "0 integralseconds integralSeconds(� m   f g��
�� 
TEXT��  ��  (� o      ���� 0 secondstring secondString(� (�(�(� r   l q(�(�(� `   l o(�(�(� o   l m����  0 howmanyseconds howManySeconds(� m   m n���� (� o      ���� &0 fractionalseconds fractionalSeconds(� (�(�(� r   r }(�(�(� I  r {��(�(�
�� .sysorondlong        doub(� l  r u(�����(� ]   r u(�(�(� m   r s���� d(� o   s t���� &0 fractionalseconds fractionalSeconds��  ��  (� ��(���
�� 
dire(� m   v w��
�� olierndS��  (� o      ���� &0 fractionalseconds fractionalSeconds(� (�(�(� Z   ~ �(�(���(�(� ?   ~ �(�(�(� o   ~ ���� &0 fractionalseconds fractionalSeconds(� m    ����� 	(� r   � �(�(�(� c   � �(�(�(� o   � ����� &0 fractionalseconds fractionalSeconds(� m   � ���
�� 
TEXT(� o      ���� &0 thefractionstring theFractionString��  (� r   � �(�(�(� c   � �(�(�(� b   � �(�(�(� m   � �(�(� �(�(�  0(� o   � ����� &0 fractionalseconds fractionalSeconds(� m   � ���
�� 
TEXT(� o      ���� &0 thefractionstring theFractionString(� (���(� L   � �(�(� b   � �(�(�(� b   � �(�(�(� b   � �(�(�(� b   � �(�(�(� b   � �(�(�(� o   � ����� 0 
hourstring 
hourString(� o   � ����� 0 minutestring minuteString(� m   � �(�(� �(�(�  :(� o   � ����� 0 secondstring secondString(� m   � �(�(� �(�(�  .(� o   � ����� &0 thefractionstring theFractionString��  (J (�(�(� l     ��������  ��  ��  (� (�(�(� i    (�(�(� I      ��(����� 0 makehhmmsssss makeHHMMSSsss(� (���(� o      ���� 0 howlong howLong��  ��  (� k     �(�(� (�(�(� r     (�(�(� _     (�(�(� o     ���� 0 howlong howLong(� m    ����(� o      ���� 0 howmanyhours howManyHours(� (�(�(� Z    +) ))))  ?    	))) o    ���� 0 howmanyhours howManyHours) m    ���� 	) r    ))) b    ))	) l   )
���)
 c    ))) o    �� 0 howmanyhours howManyHours) m    �
� 
TEXT��  �  )	 m    )) �))  :) o      �� 0 
hourstring 
hourString) ))) ?    ))) o    �� 0 howmanyhours howManyHours) m    ��  ) )�) r    %))) b    #))) b    !))) m    )) �))  0) l    )��) c     ))) o    �� 0 howmanyhours howManyHours) m    �
� 
TEXT�  �  ) m   ! ")) �) )   :) o      �� 0 
hourstring 
hourString�  ) r   ( +)!)")! m   ( ))#)# �)$)$  )" o      �� 0 
hourstring 
hourString(� )%)&)% r   , 3)')()' _   , 1)))*)) l  , /)+��)+ `   , /),)-), o   , -�� 0 howlong howLong)- m   - .���  �  )* m   / 0�� <)( o      ��  0 howmanyminutes howManyMinutes)& ).)/). Z   4 I)0)1�)2)0 ?   4 7)3)4)3 o   4 5��  0 howmanyminutes howManyMinutes)4 m   5 6�� 	)1 r   : ?)5)6)5 l  : =)7��)7 c   : =)8)9)8 o   : ;��  0 howmanyminutes howManyMinutes)9 m   ; <�
� 
TEXT�  �  )6 o      �� 0 minutestring minuteString�  )2 r   B I):);): b   B G)<)=)< m   B C)>)> �)?)?  0)= l  C F)@��)@ c   C F)A)B)A o   C D��  0 howmanyminutes howManyMinutes)B m   D E�
� 
TEXT�  �  ); o      �� 0 minutestring minuteString)/ )C)D)C r   J O)E)F)E `   J M)G)H)G o   J K�� 0 howlong howLong)H m   K L�� <)F o      ��  0 howmanyseconds howManySeconds)D )I)J)I r   P U)K)L)K _   P S)M)N)M o   P Q��  0 howmanyseconds howManySeconds)N m   Q R�� )L o      �� "0 integralseconds integralSeconds)J )O)P)O Z   V k)Q)R�)S)Q ?   V Y)T)U)T o   V W�� "0 integralseconds integralSeconds)U m   W X�� 	)R r   \ a)V)W)V l  \ _)X��)X c   \ _)Y)Z)Y o   \ ]�� "0 integralseconds integralSeconds)Z m   ] ^�
� 
TEXT�  �  )W o      �� 0 secondstring secondString�  )S r   d k)[)\)[ b   d i)])^)] m   d e)_)_ �)`)`  0)^ l  e h)a��)a c   e h)b)c)b o   e f�� "0 integralseconds integralSeconds)c m   f g�
� 
TEXT�  �  )\ o      �� 0 secondstring secondString)P )d)e)d r   l q)f)g)f `   l o)h)i)h o   l m��  0 howmanyseconds howManySeconds)i m   m n�� )g o      �� &0 fractionalseconds fractionalSeconds)e )j)k)j r   r })l)m)l I  r {�)n)o
� .sysorondlong        doub)n l  r u)p��)p ]   r u)q)r)q m   r s���)r o   s t�� &0 fractionalseconds fractionalSeconds�  �  )o �)s�
� 
dire)s m   v w�
� olierndS�  )m o      �� &0 fractionalseconds fractionalSeconds)k )t)u)t Z   ~ �)v)w)x)y)v ?   ~ �)z){)z o   ~ �� &0 fractionalseconds fractionalSeconds){ m    ��� c)w r   � �)|)})| c   � �)~))~ o   � ��~�~ &0 fractionalseconds fractionalSeconds) m   � ��}
�} 
TEXT)} o      �|�| &0 thefractionstring theFractionString)x )�)�)� ?   � �)�)�)� o   � ��{�{ &0 fractionalseconds fractionalSeconds)� m   � ��z�z 	)� )��y)� r   � �)�)�)� c   � �)�)�)� b   � �)�)�)� m   � �)�)� �)�)�  0)� o   � ��x�x &0 fractionalseconds fractionalSeconds)� m   � ��w
�w 
TEXT)� o      �v�v &0 thefractionstring theFractionString�y  )y r   � �)�)�)� c   � �)�)�)� b   � �)�)�)� m   � �)�)� �)�)�  0 0)� o   � ��u�u &0 fractionalseconds fractionalSeconds)� m   � ��t
�t 
TEXT)� o      �s�s &0 thefractionstring theFractionString)u )��r)� L   � �)�)� b   � �)�)�)� b   � �)�)�)� b   � �)�)�)� b   � �)�)�)� b   � �)�)�)� o   � ��q�q 0 
hourstring 
hourString)� o   � ��p�p 0 minutestring minuteString)� m   � �)�)� �)�)�  :)� o   � ��o�o 0 secondstring secondString)� m   � �)�)� �)�)�  .)� o   � ��n�n &0 thefractionstring theFractionString�r  (� )�)�)� l     �m�l�k�m  �l  �k  )� )�)�)� i    )�)�)� I      �j)��i�j 0 makemmss makeMMSS)� )��h)� o      �g�g 0 howlong howLong�h  �i  )� k     0)�)� )�)�)� r     )�)�)� _     )�)�)� o     �f�f 0 howlong howLong)� m    �e�e <)� o      �d�d  0 howmanyminutes howManyMinutes)� )�)�)� r    )�)�)� l   	)��c�b)� c    	)�)�)� o    �a�a  0 howmanyminutes howManyMinutes)� m    �`
�` 
TEXT�c  �b  )� o      �_�_ 0 minutestring minuteString)� )�)�)� r    )�)�)� c    )�)�)� `    )�)�)� o    �^�^ 0 howlong howLong)� m    �]�] <)� m    �\
�\ 
long)� o      �[�[  0 howmanyseconds howManySeconds)� )�)�)� Z    ))�)��Z)�)� ?    )�)�)� o    �Y�Y  0 howmanyseconds howManySeconds)� m    �X�X 	)� r    )�)�)� l   )��W�V)� c    )�)�)� o    �U�U  0 howmanyseconds howManySeconds)� m    �T
�T 
TEXT�W  �V  )� o      �S�S 0 secondstring secondString�Z  )� r   " ))�)�)� b   " ')�)�)� m   " #)�)� �)�)�  0)� l  # &)��R�Q)� c   # &)�)�)� o   # $�P�P  0 howmanyseconds howManySeconds)� m   $ %�O
�O 
TEXT�R  �Q  )� o      �N�N 0 secondstring secondString)� )��M)� L   * 0)�)� b   * /)�)�)� b   * -)�)�)� o   * +�L�L 0 minutestring minuteString)� m   + ,)�)� �)�)�  :)� o   - .�K�K 0 secondstring secondString�M  )� )�)�)� l     �J�I�H�J  �I  �H  )� )�)�)� l      �G)�)��G  )� ' ! END: Make a text file from cues    )� �)�)� B   E N D :   M a k e   a   t e x t   f i l e   f r o m   c u e s  )� )��F)� l     �E�D�C�E  �D  �C  �F       ��B)�)�)�)�)�)�)�)� B)�)�)�)�)�)�)�)�)�)�)�)�)�)�)�)�* *********	*
********************** *!*"*#*$*%*&*'*(*)***+*,*-*.*/*0*1*2*3*4*5*6*7*8*9*:*;*<*=*>*?*@*A*B*C*D*E*F*G*H*I*J*K*L*M*N*O*P*Q*R*S*T*U*V*W*X	*Y*Z`*[v�*\*]*^*_*`)�*a*b*c����A*d*e*f�@*g*h�?*i�>*j�=�<�;*k*l*m*n*o*p*q*r*s�:*t�9�8�7*u�6*v*w*x*y*z6*{�5�4�3�2�1�0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� ����������������������
�	���������B  )� �� ��������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������~�}�|�{�z�y�x�w�v�u�t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�c�b�a�`�_�^�]�\�[�Z�Y�X�W�V�U�T�S�R�Q�P�O�N�M�L�K�J�I�H�G�F�E�D�C�B�A�@�?�>�=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!�   0 totheclipboard toTheClipboard�� 0 exitstrategy exitStrategy�� 0 	makenicet 	makeNiceT�� 0 makehhmmssss makeHHMMSSss�� 0 makehhmmsssss makeHHMMSSsss�� 0 makemmss makeMMSS
�� .aevtoappnull  �   � ****�� 0 dialogtitle dialogTitle�� 0 currenttids currentTIDs�� 20 acceptablecolumnheaders acceptableColumnHeaders�� *0 customcolumnheaders customColumnHeaders�� ,0 reportingonlycolumns reportingOnlyColumns�� 0 levelcolumns levelColumns�� 0 index5_cue_target  �� 0 index6_file_target  �� 0 index8_duration  �� 0 index21_mode  �� 0 index22_sync_to_timecode  �� 0 index23_sync_mode  �� 0 index24_smpte_format  ��  0 index25_mtc_sync_source_name  �� 0 index26_ltc_sync_channel  �� 0 index27_patch  �� 0 index28_start_time  �� 0 index29_end_time  �� 0 index30_loop_start_time  �� 0 index31_loop_end_time  �� 0 index32_loop_count  �� 0 index33_infinite_loop  �� 0 index34_guarantee_sync  �� 0 index35_integrated_fade  �� 0 index36_fade_mode  �� !0 index37_stop_target_when_done  �� 0 index38_auto_stop  �� 0 index39_layer  �� 0 index40_full_screen  �� !0 index41_preserve_aspect_ratio  �� 0 index42_opacity  �� 0 index43_translation_x  �� 0 index44_translation_y  �� 0 index45_rotation  �� 0 index46_scale_x  �� 0 index47_scale_y  �� 0 index48_scale_locked  �� 0 index49_custom_rendering  �� 0 index50_do_opacity  �� 0 index51_do_translation  �� 0 index52_do_rotation  �� 0 index53_do_scale  �� 0 index54_command  �� 0 index55_channel  �� 0 index56_byte_one  �� 0 index57_byte_two  �� 0 index58_byte_combo  �� 0 index59_end_value  �� 0 index60_fade  �� 0 index61_command_format  �� 0 index62_command_number  �� 0 index63_q__number  �� 0 index64_q__list  �� 0 index65_q__path  �� 0 index66_macro  �� 0 index67_control_number  �� 0 index68_control_value  �� 0 index69_hours  � 0 index70_minutes  � 0 index71_seconds  � 0 index72_frames  � 0 index73_subframes  � 0 index74_send_time_with_set  � 0 index75_sysex_message  � 0 index76_midi_destination  � 0 index77_start_time_offset  � (0 $index78_fire_next_cue_when_loop_ends  � &0 "index79_stop_target_when_loop_ends  � 0 index80_load_time  � 0 index81_assigned_number  �  0 index85_audio_input_channels  � 0 index86_start_value  �  0 index_setlevel index_setLevel� 0 constants10_continue_mode  � 0 constants11_armed  � 0 constants12_midi_trigger  � 0 constants13_midi_command  �  0 constants16_timecode_trigger  � "0 constants17_wall_clock_trigger  � 0 constants21_mode  �  0 constants22_sync_to_timecode  � 0 constants23_sync_mode  � 0 constants24_smpte_format  � 0 constants33_infinite_loop  � 0 constants34_guarantee_sync  � 0 constants35_integrated_fade  � 0 constants36_fade_mode  � %0 !constants37_stop_target_when_done  � 0 constants38_auto_stop  � 0 constants40_full_screen  � %0 !constants41_preserve_aspect_ratio  � 0 constants48_scale_locked  �  0 constants49_custom_rendering  � 0 constants50_do_opacity  � 0 constants51_do_translation  � 0 constants52_do_rotation  � 0 constants53_do_scale  � 0 constants54_command  � 0 constants60_fade  � "0 constants74_send_time_with_set  � ,0 (constants78_fire_next_cue_when_loop_ends  � *0 &constants79_stop_target_when_loop_ends  � 0 constants84_broken  �  0 translation61_command_format  �  0 translation62_command_number  � ,0 crosspointsinenglish crosspointsInEnglish� 00 carriagereturnsinnotes carriageReturnsInNotes� 00 missingcuetargetprefix missingCueTargetPrefix� 00 missingcuetargetsuffix missingCueTargetSuffix� 60 missingcuetargetqualifier missingCueTargetQualifier� &0 invalidfiletarget invalidFileTarget� &0 missingfiletarget missingFileTarget� (0 layerthousandistop layerThousandIsTop� *0 cuelistsnotingroups cuelistsNotInGroups� .0 irrelevantcrosspoints irrelevantCrosspoints� 0 minusinfinity minusInfinity� $0 availablepresets availablePresets� 0 preset1  � 0 preset2  � 0 preset3  � 0 preset4  � 0 preset5  � 0 preset6  �~ 0 presetmapper presetMapper�} (0 userdefaultoutputs userDefaultOutputs�| 0 userotherrows userOtherRows�{ $0 userothercolumns userOtherColumns�z 0 filemade fileMade�y *0 propertiestocolumns propertiesToColumns�x "0 groupmembership groupMembership�w 0 thenavigator theNavigator�v "0 finishedreading finishedReading�u (0 instructionbutton1 instructionButton1�t (0 instructionbutton2 instructionButton2�s 0 qlabisrunning qLabIsRunning�r 0 workspacename workspaceName�q 0 	countcues 	countCues�p 0 thepresetmenu thePresetMenu�o 0 y  �n 0 m  �m 0 d  �l 0 t  �k 0 
datestring 
dateString�j 0 
timestring 
timeString�i 0 thetime theTime�h 0 newfile newFile�g 0 chosenpreset chosenPreset�f &0 userdefinedbutton userDefinedButton�e  0 levelsquestion levelsQuestion�d 0 rowsquestion rowsQuestion�c 0 rowsno rowsNo�b "0 columnsquestion columnsQuestion�a 0 	columnsno 	columnsNo�` 0 	totalrows 	totalRows�_ 0 totalcolumns totalColumns�^ 0 thetext theText�] 0 theopenfile theOpenFile�\ 0 	headerrow 	headerRow�[ 00 propertiestocolumnsref propertiesToColumnsRef�Z 0 	inenglish 	inEnglish�Y 0 fudgefactor fudgeFactor�X 0 theeta theETA�W "0 spuriousplurals spuriousPlurals�V 0 goonthen goOnThen�U  �T  �S  �R  �Q  �P  �O  �N  �M  �L  �K  �J  �I  �H  �G  �F  �E  �D  �C  �B  �A  �@  �?  �>  �=  �<  �;  �:  �9  �8  �7  �6  �5  �4  �3  �2  �1  �0  �/  �.  �-  �,  �+  �*  �)  �(  �'  �&  �%  �$  �#  �"  �!  )� � ';��*|*}��   0 totheclipboard toTheClipboard� �*~� *~  �� 0 
texttocopy 
textToCopy�  *| �� 0 
texttocopy 
textToCopy*} ������
� 
tab 
� 
ascr
� 
txdl
� 
ctxt
� .JonspClpnull���     ****� 0 currenttids currentTIDs� ���,FO��&j O���,F)� �'T��**��� 0 exitstrategy exitStrategy�  �  *  *� 'Z����'e�'h�
�	���
� 
appr� 0 dialogtitle dialogTitle
� 
disp
� 
btns
� 
dflt�
 
�	 .sysodlogaskr        TEXT� 0 currenttids currentTIDs
� 
ascr
� 
txdl� ����j��kv��� 	O���,F)� �'t��*�*��� 0 	makenicet 	makeNiceT� �*�� *�  � �  0 howlong howLong�  *� 	�������������������� 0 howlong howLong�� 0 howmanyhours howManyHours�� 0 
hourstring 
hourString��  0 howmanyminutes howManyMinutes�� 0 minutestring minuteString��  0 howmanyseconds howManySeconds�� 0 secondstring secondString�� 0 theampersand theAmpersand�� &0 theotherampersand theOtherAmpersand*� '��'�'���'���'�'�'���'�'�'�'�((��((((( ($(/(3(7(;��
�� 
TEXT�� <
�� 
long
�� 
bool� ��j  �Y hO��"E�O�j  �E�Y �k  �E�Y 	��&�%E�O��#�"E�O�j  �E�Y �k  �E�Y 	��&�%E�O��#�&E�O�j  �E�Y �k  �E�Y 	��&�%E�O�� @��	 �a a & 
a E�Y #�a 
 �a a & 
a E�Y a E�Y a E�O�a 	 �a a & 
a E�Y a E�O��%�%�%�%)� ��(L����*�*����� 0 makehhmmssss makeHHMMSSss�� ��*��� *�  ���� 0 howlong howLong��  *� 
���������������������� 0 howlong howLong�� 0 howmanyhours howManyHours�� 0 
hourstring 
hourString��  0 howmanyminutes howManyMinutes�� 0 minutestring minuteString��  0 howmanyseconds howManySeconds�� "0 integralseconds integralSeconds�� 0 secondstring secondString�� &0 fractionalseconds fractionalSeconds�� &0 thefractionstring theFractionString*� ������(e(r(w({��(�(���������(�(�(����� 	
�� 
TEXT�� <�� d
�� 
dire
�� olierndS
�� .sysorondlong        doub�� ���"E�O�� ��&�%E�Y �j ��&%�%E�Y �E�O��#�"E�O�� 
��&E�Y 	��&%E�O��#E�O�k"E�O�� 
��&E�Y 	��&%E�O�k#E�O� ��l E�O�� 
��&E�Y 	�%�&E�O��%�%�%a %�%)� ��(�����*�*����� 0 makehhmmsssss makeHHMMSSsss�� ��*��� *�  ���� 0 howlong howLong��  *� 
���������������������� 0 howlong howLong�� 0 howmanyhours howManyHours�� 0 
hourstring 
hourString��  0 howmanyminutes howManyMinutes�� 0 minutestring minuteString��  0 howmanyseconds howManySeconds�� "0 integralseconds integralSeconds�� 0 secondstring secondString�� &0 fractionalseconds fractionalSeconds�� &0 thefractionstring theFractionString*� ������))))#��)>)_����������)�)�)�)����� 	
�� 
TEXT�� <���
�� 
dire
�� olierndS
�� .sysorondlong        doub�� c�� ���"E�O�� ��&�%E�Y �j ��&%�%E�Y �E�O��#�"E�O�� 
��&E�Y 	��&%E�O��#E�O�k"E�O�� 
��&E�Y 	��&%E�O�k#E�O� ��l E�O�� 
��&E�Y �� �%�&E�Y a �%�&E�O��%a %�%a %�%)� ��)���*�*���� 0 makemmss makeMMSS� �*�� *�  �� 0 howlong howLong�  *� ������ 0 howlong howLong�  0 howmanyminutes howManyMinutes� 0 minutestring minuteString�  0 howmanyseconds howManySeconds� 0 secondstring secondString*� ����)�)�� <
� 
TEXT
� 
long� 	� 1��"E�O��&E�O��#�&E�O�� 
��&E�Y 	��&%E�O��%�%)� �*���*�*��
� .aevtoappnull  �   � *****� k    :g*�*�  =*�*�  I*�*�  R*�*� �*�*� �*�*� �*�*� �*�*� �*�*� *�*� ;*�*� P*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� *�*� %*�*� 5*�*� E*�*� Q*�*� ]*�*� i*�*� y*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� *�*� %*�*� 9*�*� M*�*� a*�*� u*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� 	*�*� *�*� !*�*� -*�*� 9*�*� E*�*� Q*�*� ]*�*� i*�*� u*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� *�*� $*�*� 2*�*� O*�*� `*�*� m*�*� z*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� *�*� *�*�  *�*� -*�*� :*�*� G*�*� T*�*� a*�*� n*�*� {*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� �*�*� *�*� *�*� 	�*�*� 
�*�*� 
�*�*� *�*� *�*� "+ +  I++ Y++ c++ o++ y++ �++ �++ �++ �+	+	 �+
+
 p++ u++ �++ �++ �++ �++ �++  ++ ++ 
++ ��  �  �  *� ������� 0 eachitem eachItem� 0 i  � 0 j  � 0 
eachcolumn 
eachColumn� 0 	eachgroup 	eachGroup� "0 eachlevelcolumn eachLevelColumn*�� B���� \ ` d h l p t x | � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �  $)-159=AEIMQVZ^bfjnrvz~������������������������!%)-158��EH�Z^bfjnq���������������"��/2�?B�N�Z�f�sv���������������������~����}�|"�{/36�zCGJ�yW[^�xkor�w��v��u��t��s��r��q��p��o��n��m��l�k�j�i*�h6�gB�fN�eZ�df�cr�b~�a��`��_��^��]��\��[��Z��Y��X��W�V!�U-�T<@C�SW[^�Rhk�Qux�P�������O���N���M������L�K���J���I�����H�G�F�E(+�D58�CBE�BOR�A\_�@il�?vy�>���=���<���;���:��������9���8���7���6��5�4"&*.26:>BFJNSW[_cgkosw{�������������������������������			
						"	&	*	/	3	7	;	?	C	G	K	O	S	W	[	`	d	h	l	p	t	x	|	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	��3�2	�	�	�	�	�








#
'
+
0
4
8
<
@
D
H
L
P
T
X
\
`
d
i
m
q
u
y
}
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
��1�0
�
�
�
��/�.
�
�	�-�,�+*.26:>BE�*�)SV�(`�'l�&v�%��$�#��"��������!��������������� �#'+/48<@DHLPTX\aeimquy}������������������������������� !%)-159>BFJNRVZ^bgkn���}����������������������������(�P8���DHK�O�R�
�	Z�i�����������������������I&*-08Bi�+�g�u���� ������������������������������������������������������;CK��v����������������������������������������������)-/13��ac��nx}�������������������������������"������9J��`z��������� ,/2�9�����bo�~��������6�Hgikmy|����������������� �������bnquy������������f���������)������������������~�}�|�{�z�y�x�w�v�u�t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�c�b�a�`�_�^�]�\�[��Z�Y�X�W�V�U�T�S�R�Q�P�O�N�M�L�K�J�I�H�GJ�F�E�D�C�B�A�@�?�>�=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� �!b��!��������������������
�	��������� ��������������������$�%��%;����%Q��������������%�%�%�%�&&&
&������&S��&b&d&p&t&w&{&�&�������������&�&�&�&�&�������&�&�&�&���+'
''� 0 dialogtitle dialogTitle
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
TEXT� � ,0 reportingonlycolumns reportingOnlyColumns� 0 levelcolumns levelColumns� � 0 index5_cue_target  � 0 index6_file_target  � � 0 index8_duration  � 0 index21_mode  � 0 index22_sync_to_timecode  � 0 index23_sync_mode  � 0 index24_smpte_format  �  0 index25_mtc_sync_source_name  � 0 index26_ltc_sync_channel  � � 0 index27_patch  � 0 index28_start_time  � 0 index29_end_time  � 0 index30_loop_start_time  � 0 index31_loop_end_time  � 0 index32_loop_count  � 0 index33_infinite_loop  � 0 index34_guarantee_sync  � 0 index35_integrated_fade  � 0 index36_fade_mode  � !0 index37_stop_target_when_done  � 0 index38_auto_stop  � 0 index39_layer  � 0 index40_full_screen  �~ !0 index41_preserve_aspect_ratio  �} 0 index42_opacity  �| 0 index43_translation_x  �{ 0 index44_translation_y  �z 0 index45_rotation  �y 0 index46_scale_x  �x 0 index47_scale_y  �w 0 index48_scale_locked  �v 0 index49_custom_rendering  �u 0 index50_do_opacity  �t 0 index51_do_translation  �s 0 index52_do_rotation  �r 0 index53_do_scale  �q 0 index54_command  �p 0 index55_channel  �o 0 index56_byte_one  �n 0 index57_byte_two  �m 0 index58_byte_combo  �l 0 index59_end_value  �k 0 index60_fade  �j 0 index61_command_format  �i 0 index62_command_number  �h 0 index63_q__number  �g 0 index64_q__list  �f 0 index65_q__path  �e 0 index66_macro  �d 0 index67_control_number  �c 0 index68_control_value  �b 0 index69_hours  �a 0 index70_minutes  �` 0 index71_seconds  �_ 0 index72_frames  �^ 0 index73_subframes  �] 0 index74_send_time_with_set  �\ 0 index75_sysex_message  �[ 0 index76_midi_destination  �Z 0 index77_start_time_offset  �Y (0 $index78_fire_next_cue_when_loop_ends  �X &0 "index79_stop_target_when_loop_ends  �W 0 index80_load_time  �V 0 index81_assigned_number  �U  0 index85_audio_input_channels  �T 0 index86_start_value  �S  0 index_setlevel index_setLevel�R 0 constants10_continue_mode  �Q 0 constants11_armed  �P 0 constants12_midi_trigger  �O 0 constants13_midi_command  �N  0 constants16_timecode_trigger  �M "0 constants17_wall_clock_trigger  �L �K 0 constants21_mode  �J  0 constants22_sync_to_timecode  �I 0 constants23_sync_mode  �H 0 constants24_smpte_format  �G 0 constants33_infinite_loop  �F 0 constants34_guarantee_sync  �E 0 constants35_integrated_fade  �D 0 constants36_fade_mode  �C %0 !constants37_stop_target_when_done  �B 0 constants38_auto_stop  �A 0 constants40_full_screen  �@ %0 !constants41_preserve_aspect_ratio  �? 0 constants48_scale_locked  �>  0 constants49_custom_rendering  �= 0 constants50_do_opacity  �< 0 constants51_do_translation  �; 0 constants52_do_rotation  �: 0 constants53_do_scale  �9 0 constants54_command  �8 0 constants60_fade  �7 "0 constants74_send_time_with_set  �6 ,0 (constants78_fire_next_cue_when_loop_ends  �5 *0 &constants79_stop_target_when_loop_ends  �4 0 constants84_broken  �3 p�2  0 translation61_command_format  �1 4�0  0 translation62_command_number  �/ ,0 crosspointsinenglish crosspointsInEnglish�. �- 00 carriagereturnsinnotes carriageReturnsInNotes�, 00 missingcuetargetprefix missingCueTargetPrefix�+ 00 missingcuetargetsuffix missingCueTargetSuffix�* �) 60 missingcuetargetqualifier missingCueTargetQualifier�( &0 invalidfiletarget invalidFileTarget�' &0 missingfiletarget missingFileTarget�& (0 layerthousandistop layerThousandIsTop�% *0 cuelistsnotingroups cuelistsNotInGroups�$ .0 irrelevantcrosspoints irrelevantCrosspoints�#���" 0 minusinfinity minusInfinity�! $0 availablepresets availablePresets�  � 0 preset1  � 0 preset2  � $� 0 preset3  � 0 preset4  � 0 preset5  � 
� 0 preset6  � 0 presetmapper presetMapper� (0 userdefaultoutputs userDefaultOutputs� 0 userotherrows userOtherRows� $0 userothercolumns userOtherColumns� 0 filemade fileMade� *0 propertiestocolumns propertiesToColumns� "0 groupmembership groupMembership� 0 thenavigator theNavigator
� 
appr
� 
disp
� 
btns
� 
dflt
� 
cbtn
�
 .sysodlogaskr        TEXT
�	 
bhit� "0 finishedreading finishedReading� (0 instructionbutton1 instructionButton1�  0 totheclipboard toTheClipboard� (0 instructionbutton2 instructionButton2
� 
prcs+  
� 
pnam� 0 qlabisrunning qLabIsRunning
� 
givu
�  
qDoc�� 0 workspacename workspaceName
�� 
aCue�� 0 	countcues 	countCues��  ��  
�� 
prmp
�� 
inSL
�� .gtqpchltns    @   @ ns  �� 0 thepresetmenu thePresetMenu
�� 
Krtn
�� 
year�� 0 y  
�� 
mnth�� 0 m  
�� 
day �� 0 d  
�� 
tstr�� 0 t  
�� .misccurdldt    ��� null��'�� d�� 0 
datestring 
dateString�� 0 
timestring 
timeString
�� 
citm�� 0 thetime theTime
�� 
dflc
�� afdrdesk
�� .earsffdralis        afdr
�� 
lfiv
�� .sysostdfalis    ��� null�� 0 originalfile originalFile
�� .rdwrread****        ****�� 0 thetext theText�� 0 exitstrategy exitStrategy
�� 
extn�� 0 theextension theExtension
�� 
ppth�� 0 newpath newPath�� 0 thefullpath theFullPath
�� 
ctxt
�� 
leng�� 0 newfile newFile
�� 
perm
�� .rdwropenshor       file�� 0 theopenfile theOpenFile�� 0 chosenpreset chosenPreset�� &0 userdefinedbutton userDefinedButton��  0 levelsquestion levelsQuestion
�� 
nmbr�� 0 	totalrows 	totalRows�� 0 totalcolumns totalColumns�� 0 rowsquestion rowsQuestion
�� 
dtxt
�� 
ttxt�� 0 rowsno rowsNo�� 
�� 
bool�� "0 columnsquestion columnsQuestion�� 0 	columnsno 	columnsNo�� 1
�� 
tab 
�� 
cpar�� 0 	headerrow 	headerRow�� 00 propertiestocolumnsref propertiesToColumnsRef� 0 	inenglish 	inEnglish� 0 dirtyheader dirtyHeader
� 
rest� 0 therest theRest� 0 dirtycolumns dirtyColumns� 0 cleancolumns cleanColumns� 0 
cleanstore 
cleanStore� 0 cleanheader cleanHeader� 0 englishheader englishHeader
� 
ret � q� 0 fudgefactor fudgeFactor� 0 theeta theETA� (� 0 	makenicet 	makeNiceT� "0 spuriousplurals spuriousPlurals� 0 goonthen goOnThen
� .miscactvnull��� ��� null
� 
aSlt� 0 	starttime 	startTime� R
� 
qTyp� 0 	allgroups 	allGroups� 0 allgroupsref allGroupsRef
� 
qNam� 0 
grouptitle 
groupTitle
� 
ID  � 0 childrencues childrenCues� "0 childrencuesref childrenCuesRef
� 
long� 0 	timetaken 	timeTaken� 
� 
pisf� (0 groupmembershipref groupMembershipRef� 0 thecue theCue� 0 theproperties theProperties� $0 thepropertiesref thePropertiesRef� 0 thetype theType
� 
qGMo
� GRUPqGCL� 0 theitem theItem
� 
qNot� 0 	cleantext 	cleanText� 0 	noreturns 	noReturns
� 
qQTr
� 
msng� 0 targettitle targetTitle
� 
qFTr
� 
alis
� 
psxp
� 
qPre� 0 makehhmmssss makeHHMMSSss
� 
qDur� 	
� 
qPos
� 
qCon
� ContNoCo
� ContDoCo
� ContDoFo� 
� 
qArm
� 
qUMT
� YorNYyes
� YorNNnoo� 
�~ 
qMSt
�} MICONtOn
�| MICONtOf
�{ MICOPrCh
�z MICOCtCh
�y MICOKyPr
�x MICOChPr
�w 
qMB1
�v 
qMB2
�u 
qUTC
�t 
qUWC�s 
�r 
qwcH�q 
�p 
qwcM�o 
�n 
qwcS�m 
�l GRUPqGSS
�k GRUPqGHS
�j GRUPqGFA
�i GRUPqGFR�h 
�g 
qSTC�f 
�e 
qSMo
�d MTLTsynM
�c MTLTsynL�b 
�a 
qSMP
�` SMPTtfFP
�_ SMPTtiFP
�^ SMPTthDR
�] SMPTthND�\ 
�[ 
qMTN�Z 
�Y 
qLTC�X 
�W 
qPch�V 
�U 
qSta�T 0 makehhmmsssss makeHHMMSSsss�S 
�R 
qEnd�Q !
�P 
qInf�O #
�N 
qIFa
�M 
qAbs
�L ABREABSO
�K ABRERELA�J %
�I 
qAuS�H '
�G 
qLay
�F 
qFSc�E )
�D 
qPAs�C *
�B 
qOpa�A +
�@ 
qTrX�? ,
�> 
qTrY�= -
�< 
qRot�; .
�: 
qScX�9 /
�8 
qScY�7 2
�6 
qDoO�5 3
�4 
qDoT
�3 
qDoR�2 5
�1 
qDoS�0 6
�/ 
qCOm
�. MICOPiBe�- 7
�, 
qCHa�+ 8
�* 
qBy1�) 9
�( 
qBy2�' :
�& 
qBy3�%  �$ ;
�# 
qEVA�" <
�! 
qDoF�  =
� 
qFor� >
� 
qCom� ?
� 
qmsN� @
� 
qmsL� A
� 
qmsP� B
� 
qMac� C
� 
qCNt� D
� 
qCNv� E
� 
qHou� F
� 
qMin� G
� 
qSec�
 H
�	 
qFra� I
� 
qSFr� J
� 
qSTW� K
� 
qSEX� M
� 
qStA�  P
�� 
qLTi
�� 
qASN�� 0 thiscue thisCue�� S�� T
�� 
qBrk�� U
�� 
qNCh�� V
�� 
qSVA�� 0 audiochannels audioChannels
�� 
cwor�� 0 excelcleanup excelCleanup�� 0 therow theRow�� 0 thelevel theLevel�� 0 	thecolumn 	theColumn
�� 
levR
�� 
levC
�� .QLablevgnull���     aCue�� 0 makemmss makeMMSS
�� 
refn
�� .rdwrwritnull���     ****
�� .rdwrclosnull���     ****�� 0 whatnext whatNext�� ,0 openallcolumnsastext openAllColumnsAsText
�� e249� 
�� 
5016
�� 
5225
�� 
5219
�� .smXLXoTxnull��� ��� null
�� .aevtodocnull  �    alis
�� 
cwin
�� 
pzum
�� .miscmvisnull���    obj + ������
�� 
errn������  �:h�E�O��,E�O�����������a a a a a a a a a a a a a a a a a  a !a "a #a $a %a &a 'a (a )a *a +a ,a -a .a /a 0a 1a 2a 3a 4a 5a 6a 7a 8a 9a :a ;a <a =a >a ?a @a Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua VvE` WOa XkvE` YO $_ Y[a Za [l \kh  �a ]&_ W6G[OY��Oa ^a _a `a aa bvE` cO $_ c[a Za [l \kh  �a ]&_ W6G[OY��OjvE` dOa ea fa ga ha ia ja ka la ma na oa pa qvE` rOa sa tlvE` uOa va wa xa ya za {a |a }vE` ~Oa a �lvE` �Oa �kvE` �Oa �kvE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �a �a �a �a �a �a �vE` �Oa �a �lvE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �a �lvE` �Oa �kvE` �Oa �a �lvE` �Oa �a �lvE` �Oa �a �lvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �a �mvE` �Oa �a �lvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` �Oa �kvE` OakvE`OakvE`OakvE`OakvE`Oa	kvE`
OakvE`OakvE`OakvE`OakvE`OakvE`OakvE`OaalvE`OakvE`OaaamvE`Oa a!a"mvE`#Oa$a%lvE`&Oa'a(lvE`)Oa*a+a,a-a.a/a �vE`0Oa1a2lvE`3Oa4a5lvE`6Oa7a8a9a:a;a<vE`=Oa>a?lvE`@OaAaBlvE`COaDaEaFaGa bvE`HOaIaJlvE`KOaLaMlvE`NOaOaPlvE`QOaRaSlvE`TOaUaVlvE`WOaXaYlvE`ZOa[a\lvE`]Oa^a_lvE``OaaablvE`cOadaelvE`fOagahlvE`iOajaklvE`lOamanlvE`oOapaqlvE`rOasatauavawaxaya }vE`zOa{a|lvE`}Oa~alvE`�Oa�a�lvE`�Oa�a�lvE`�Oa�a�lvE`�Oa�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�vE`�Oa�a�a�a�a aaaaaaaaa	a
aaaaaaaaaaaaaaaaaaaaaa a!a"a#a$a%a&a'a(a)a*a+a,a-a.a/a0vE`1Oa2a3a4a5a bvE`6O -ka7kh �a8%a ]&_66GOa9�%a ]&_66G[OY��Oa:E`;Oa<a=lvE[a [k/E`>Z[a [l/E`?ZOa@aAaBaCaDaEaFaGaHvE`IOaJaKlvE`LOaME`NOaOkvE`POaQE`ROaSE`TOaUaVlvE`WOaXaYaZa[a\a]a^a }vE`_Oa`aaabacadaeafagahaiajakalamanvE`oOapaqarasatauavawaxayaza{a|a}a~aa�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a0vE`�Oa�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�a�vE`�O_ WE`�Oa�a�a�a�a�a�a �vE`�Oa�a�a�a�a�a�a�a�a�a�a�vE`�O_o_�_�_�_�_�a �vE`�Oa�E`�Oa�E`�Oa�E`�OfE`�OjvE`�OjvE`�O.�a�E`�O�h_�a� a�a��a�ka�a�a�a�mva�a�a�a�a��a�,E`�O_�a� KfE`�O?h_�e a�E`�O �h_�a�a�a�%a %a%a%a%a%a%a%a%a%a��a�ka�a	a
amva�aaH�a�,E`�O_�a  )_ Wk+Y _�a  
eE`�Y h[OY�wO_�a  �aE`O �h_aaa%a%a%a%a%a%a%a��a�ka�aaamva�aaH�a�,E`O_a   )_ Wk+Y _a!  
eE`�Y h[OY��Y h[OY��Y hOP[OY�kOa" *a#-a$[a%,\Za&81j \E`'UO_'j  -a(a��a�ja�a)kva�a*a+a<a��OhY hOa, V &*a-k/a%,E`.O*a-k/a/-j \E`0W /X12a3a��a�ja�a4kva�a5a+a<a��OhUO__a6a7a��a8__a [k/a �9a ]&E`:O_:a;  hY hOa<��,FO*a=a>a?a@aAaBaCaDaEaHlFE[a>,E`?Z[a@,E`AZ[aB,E`CZ[aD,E`EZO_?aG _AaH _Ca ]&E`IO_Ea ]&E`JO_I[aK\[Zm\Za b2aL%_I[aK\[Za<\Za �2%aM%_I[aK\[Za }\ZaH2%aN%_J[aK\[Zk\Zl2%_J[aK\[Za b\Za<2%a ]&E`OO_:__a [k/ 
*a6aPaQaRjSaTfa �UE`VO _VjWE`XW X12)j+YOhOa" u_VaZ,E`[O_[a\  _Va],E`^Y 1_Va],E`_O__[a`\[Zk\Z__aa,_[aa,k2E`^O_^ab%_.%ac%_O%ad%_[%E`eUO _eafelgEQ`hOeE`�W /X12aia��a�ja�ajkva�akaH�O���,FOhOPY�alaRjS%am%_.%an%�%ao%_O%ap%E`eO 7l__j \kh _:__a [�/  _�a [�k/E`qOY h[OY��Oar_�%as%E`tOaua��a�av_tawmva�_ta ��a�,E`xO_x_t  &l_�ay&lvE[a [k/E`zZ[a [l/E`{ZY9_xa| .a}E`~O yh_~aa�a��a�a�kva�a�a�_�aH�a�,E`~O 2_~ay&E`�O_�k
 _�a�a�& a�E`~Y hW X12a�E`~[OY��Oa�E`�O yh_�a�a�a��a�a�kva�a�a�_�aH�a�,E`�O 2_�ay&E`�O_�k
 _�a�a�& a�E`�Y hW X12a�E`�[OY��O_�k_�klvE[a [k/E`zZ[a [l/E`{ZY hO_xa� 7 1j_zkh   j_{kh �a�%�%a ]&_q6G[OY��[OY��Y hO_���,FO_qa`&E`XOa���,FO _eafelgEQ`hOeE`�W /X12a�a��a�ja�a�kva�a�aH�O���,FOhOPO_���,FO _Xa�k/aK-E`�W X12)j+YOhO Rk_ Wj \kh j_�6GO 6k_�j \kh _�a [�/_ Wa [�/  �_�a [�/FY h[OY��[OY��O)a�,E`�O -k_�j \kh _�a [�/a� �_ d6GY h[OY��O_ dj \j_a�a�%a��a�ka�a�a�lva�a�aH�a�,E`�O_�a� "_Xa�k/E`�O_Xa�-a�,E`�O_�aK-E`�OjvE`�O U_�[a Za [l \kh �a� +a���,FO�aK-E`�Oa���,FO_�a ]&_�6GY �a ]&_�6G[OY��O_���,FO_�a`&E`�O Gk_6j \lh _6a [�/��,FO_�aK-E`�O_6a [�k/��,FO_�a`&E`�[OY��O_�j \j  _�E`XY %_���,FO_�_�%_�%a`&E`XO_���,FY hY hO_0_�j \a�! E`�Oa�l_� j_�l$ E`�O_�a� �)_�k+�E`JOa�E`�O �a�kih �k  a�E`�Y hOa�_0%a ]&a�%_J%a�%�%a ]&_�%a�%a��a�ja�a�a�lva�a�a�a�a+ka q�a�,E`�O_�a�  Y h[OY��Y hOa,#*j�Oa�a��a�ka�a�kva�a�a+ka��O*jFa�,E`�O*a-k/"�_�a [a�/jL*a/-a$[a�,\Za�81E`�O)a�,E`�O_�[a Za [l \kh �a�,a ]&E`�O_�a�  2�a%,a ]&E`�O_�a�  aԤa�,%a ]&E`�Y hY hO�a/-a�,E`�O)a�,E`�O �k_�j \kh _�a [�/_�6GO_�_�6GO*jFa�,_�a�&E`�O_�a�#j 	 _�ja�& Aa,a�,e  1a�a��a�ka�a�a�lva�a�a�a�a+ka q�Y hY h[OY�u[OY��O)a�,E`�Y hO!uk_0kh *a/�/E`�OjvE`�O  h_�j \_�j \a�_�6G[OY��O)a�,E`�O_�a�,a ]&E`�O_�a� 	 _�a�,a� a�& a�E`�OPY hO_�a [k/j _�_�a [_�a [k/E/FY hO_�a [l/j )_�a%,a ]&E`�O_�_�a [_�a [l/E/FY hO_�a [m/j )_�a�,a ]&E`�O_�_�a [_�a [m/E/FY hO_�a [a b/j a_�a�,a ]&E`�O_�a� C_�a�-E`�O_;��,FO_�a`&E`�O_���,FO_�_�a [_�a [a b/E/FY hY hO_ r_�	 _�a [a</ja�& �_�a�,E`�O_�a�  ]_I_� E ?k_Ij \lh _�_Ia [�/  _>_Ia [�k/%_?%E`�OY h[OY��Y _>_?%E`�Y Q_�a�,a ]&E`�O_�a�  6_�a%,a ]&E`�O_�a�  a�_�a�,%a ]&E`�Y hY hO_�_�a [_�a [a</E/FY hO_ u_�	 _�a [a �/ja�& � <_�a�,a ]&E`�O_�a�  _NE`�Y _�a�&a�,a ]&E`�W =X12 5k_ uj \kh _�_ ua [�/  _La [�/E`�OY h[OY��O_�_�a [_�a [a �/E/FY hO_�a [a }/j 4_�a�,E`OO)_Ok+�E`�O_�_�a [_�a [a }/E/FY hO_ ~_�	 _�a [aH/ja�& 4_�a�,E`OO)_Ok+�E`�O_�_�a [_�a [aH/E/FY hO_�a [a�/j 4_�a�,E`OO)_Ok+�E`�O_�_�a [_�a [a�/E/FY hO_�a [a�/j �_�a�,E`�O_�a    _#a [k/_�a [_�a [a�/E/FY S_�a   _#a [l/_�a [_�a [a�/E/FY +_�a   _#a [m/_�a [_�a [a�/E/FY hY hO_�a [a/j ^_�a,E`�O_�e   _&a [k/_�a [_�a [a/E/FY )_�f   _&a [l/_�a [_�a [a/E/FY hY hO_�a [a q/j b_�a,E`�O_�a   _)a [k/_�a [_�a [a q/E/FY +_�a   _)a [l/_�a [_�a [a q/E/FY hY hO_�a [a/j_�a	,E`�O_�a
   _0a [k/_�a [_�a [a/E/FY �_�a   _0a [l/_�a [_�a [a/E/FY �_�a   _0a [m/_�a [_�a [a/E/FY �_�a  "_0a [a b/_�a [_�a [a/E/FY W_�a  "_0a [a</_�a [_�a [a/E/FY -_�a  "_0a [a �/_�a [_�a [a/E/FY hY hO_�a [an/j +_�a,a ]&E`�O_�_�a [_�a [an/E/FY hO_�a [a�/j O_�a	,a	 _�a	,aa�& +_�a,a ]&E`�O_�_�a [_�a [a�/E/FY hY hO_�a [a7/j b_�a,E`�O_�a   _3a [k/_�a [_�a [a7/E/FY +_�a   _3a [l/_�a [_�a [a7/E/FY hY hO_�a [a�/j b_�a,E`�O_�a   _6a [k/_�a [_�a [a�/E/FY +_�a   _6a [l/_�a [_�a [a�/E/FY hY hO_�a [a/j +_�a,a ]&E`�O_�_�a [_�a [a/E/FY hO_�a [a/j +_�a,a ]&E`�O_�_�a [_�a [a/E/FY hO_�a [a/j +_�a,a ]&E`�O_�_�a [_�a [a/E/FY hO_ �_�	 _�a [a/ja�& �_�a�,E`�O_�a�   _=a [k/_�a [_�a [a/E/FY �_�a   _=a [l/_�a [_�a [a/E/FY _�a   _=a [m/_�a [_�a [a/E/FY W_�a  "_=a [a b/_�a [_�a [a/E/FY -_�a  "_=a [a</_�a [_�a [a/E/FY hY hO_ �_�	 _�a [a/ja�& b_�a ,E`�O_�a   _@a [k/_�a [_�a [a/E/FY +_�a   _@a [l/_�a [_�a [a/E/FY hY hO_ �_�	 _�a [a!/ja�& b_�a",E`�O_�a#   _Ca [k/_�a [_�a [a!/E/FY +_�a$   _Ca [l/_�a [_�a [a!/E/FY hY hO_ �_�	 _�a [a%/ja�& �_�a&,E`�O_�a'   _Ha [k/_�a [_�a [a%/E/FY }_�a(   _Ha [l/_�a [_�a [a%/E/FY U_�a)   _Ha [m/_�a [_�a [a%/E/FY -_�a*  "_Ha [a b/_�a [_�a [a%/E/FY hY hO_ �_�	 _�a [a+/ja�& 9_�a,,a ]&E`�O_�a- _�_�a [_�a [a+/E/FY hY hO_ �_�	 _�a [a./ja�& +_�a/,a ]&E`�O_�_�a [_�a [a./E/FY hO_ �_�	 _�a [a0/ja�& +_�a1,a ]&E`�O_�_�a [_�a [a0/E/FY hO_ �_�	 _�a [a2/ja�& H_�a3,E`OO_Oa�  
jE`OY hO)_Ok+4E`�O_�_�a [_�a [a2/E/FY hO_ �_�	 _�a [a5/ja�& 4_�a6,E`OO)_Ok+4E`�O_�_�a [_�a [a5/E/FY hO_ �_�	 _�a [a7/ja�& ^_�a8,E`�O_�e   _Ka [k/_�a [_�a [a7/E/FY )_�f   _Ka [l/_�a [_�a [a7/E/FY hY hO_ �_�	 _�a [a9/ja�& b_�a:,E`�O_�a   _Qa [k/_�a [_�a [a9/E/FY +_�a   _Qa [l/_�a [_�a [a9/E/FY hY hO_ �_�	 _�a [a�/ja�& b_�a;,E`�O_�a<   _Ta [k/_�a [_�a [a�/E/FY +_�a=   _Ta [l/_�a [_�a [a�/E/FY hY hO_ �_�	 _�a [a>/ja�& ^_�a?,E`�O_�e   _Wa [k/_�a [_�a [a>/E/FY )_�f   _Wa [l/_�a [_�a [a>/E/FY hY hO_ �_�	 _�a [a@/ja�& A_�aA,a ]&E`�O_�aB  _PE`�Y hO_�_�a [_�a [a@/E/FY hO_ �_�	 _�a [a�/ja�& ^_�aC,E`�O_�e   _]a [k/_�a [_�a [a�/E/FY )_�f   _]a [l/_�a [_�a [a�/E/FY hY hO_ �_�	 _�a [aD/ja�& ^_�aE,E`�O_�e   _`a [k/_�a [_�a [aD/E/FY )_�f   _`a [l/_�a [_�a [aD/E/FY hY hO_ �_�	 _�a [aF/ja�& +_�aG,a ]&E`�O_�_�a [_�a [aF/E/FY hO_ �_�	 _�a [aH/ja�& +_�aI,a ]&E`�O_�_�a [_�a [aH/E/FY hO_ �_�	 _�a [aJ/ja�& +_�aK,a ]&E`�O_�_�a [_�a [aJ/E/FY hO_ �_�	 _�a [aL/ja�& +_�aM,a ]&E`�O_�_�a [_�a [aL/E/FY hO_ �_�	 _�a [aN/ja�& +_�aO,a ]&E`�O_�_�a [_�a [aN/E/FY hO_ �_�	 _�a [aP/ja�& +_�aQ,a ]&E`�O_�_�a [_�a [aP/E/FY hO_ �_�	 _�a [aR/ja�& ^_�aS,E`�O_�e   _ia [k/_�a [_�a [aR/E/FY )_�f   _ia [l/_�a [_�a [aR/E/FY hY hO_ �_�	 _�a [aT/ja�& ^_�aU,E`�O_�e   _la [k/_�a [_�a [aT/E/FY )_�f   _la [l/_�a [_�a [aT/E/FY hY hO_ �_�	 _�a [a0/ja�& ^_�aV,E`�O_�e   _oa [k/_�a [_�a [a0/E/FY )_�f   _oa [l/_�a [_�a [a0/E/FY hY hO_ �_�	 _�a [aW/ja�& ^_�aX,E`�O_�e   _ra [k/_�a [_�a [aW/E/FY )_�f   _ra [l/_�a [_�a [aW/E/FY hY hO_ �_�	 _�a [aY/ja�&2_�aZ,E`�O_�a
   _za [k/_�a [_�a [aY/E/FY �_�a   _za [l/_�a [_�a [aY/E/FY �_�a   _za [m/_�a [_�a [aY/E/FY �_�a  "_za [a b/_�a [_�a [aY/E/FY �_�a  "_za [a</_�a [_�a [aY/E/FY W_�a  "_za [a �/_�a [_�a [aY/E/FY -_�a[  "_za [a }/_�a [_�a [aY/E/FY hY hO_ �_�	 _�a [a\/ja�& +_�a],a ]&E`�O_�_�a [_�a [a\/E/FY hO_ �_�	 _�a [a^/ja�& =_�aZ,a[ +_�a_,a ]&E`�O_�_�a [_�a [a^/E/FY hY hO_ �_�	 _�a [a`/ja�& a_�aZ,a[	 _�aZ,aa�&	 _�aZ,aa�& +_�aa,a ]&E`�O_�_�a [_�a [a`/E/FY hY hO_ �_�	 _�a [ab/ja�& A_�aZ,a[  /_�ac,ada ]&E`�O_�_�a [_�a [ab/E/FY hY hO_ �_�	 _�a [ae/ja�& O_�aZ,a[ _�af,a ]&E`�Y _�af,ada ]&E`�O_�_�a [_�a [ae/E/FY hO_ �_�	 _�a [ag/ja�& b_�ah,E`�O_�a   _}a [k/_�a [_�a [ag/E/FY +_�a   _}a [l/_�a [_�a [ag/E/FY hY hO_ �_�	 _�a [ai/ja�& |_�aj,a ]&E`�O_�_� = 7k_�j \lh _�_�a [�/  _�a [�k/E`�OY h[OY��Y _�ak%E`�O_�_�a [_�a [ai/E/FY hO_ �_�	 _�a [al/ja�& |_�am,a ]&E`�O_1_� = 7k_1j \lh _�_1a [�/  _1a [�k/E`�OY h[OY��Y _�an%E`�O_�_�a [_�a [al/E/FY hO_ �_�	 _�a [ao/ja�& +_�ap,a ]&E`�O_�_�a [_�a [ao/E/FY hO_ �_�	 _�a [aq/ja�& +_�ar,a ]&E`�O_�_�a [_�a [aq/E/FY hO_ �_�	 _�a [as/ja�& +_�at,a ]&E`�O_�_�a [_�a [as/E/FY hO_ �_�	 _�a [au/ja�& +_�av,a ]&E`�O_�_�a [_�a [au/E/FY hO_ �_�	 _�a [aw/ja�& +_�ax,a ]&E`�O_�_�a [_�a [aw/E/FY hO_ �_�	 _�a [ay/ja�& +_�az,a ]&E`�O_�_�a [_�a [ay/E/FY hO_ �_�	 _�a [a{/ja�& +_�a|,a ]&E`�O_�_�a [_�a [a{/E/FY hO_ _�	 _�a [a}/ja�& +_�a~,a ]&E`�O_�_�a [_�a [a}/E/FY hO__�	 _�a [a/ja�& +_�a�,a ]&E`�O_�_�a [_�a [a/E/FY hO__�	 _�a [a�/ja�& +_�a�,a ]&E`�O_�_�a [_�a [a�/E/FY hO__�	 _�a [a�/ja�& +_�a�,a ]&E`�O_�_�a [_�a [a�/E/FY hO__�	 _�a [a�/ja�& ^_�a�,E`�O_�e   _�a [k/_�a [_�a [a�/E/FY )_�f   _�a [l/_�a [_�a [a�/E/FY hY hO_
_�	 _�a [a�/ja�& +_�a�,a ]&E`�O_�_�a [_�a [a�/E/FY hO__�	 _�a [a�/ja�& 4_�a�,E`OO)_Ok+4E`�O_�_�a [_�a [a�/E/FY hO__�	 _�a [a�/ja�& 4_�a�,E`OO)_Ok+4E`�O_�_�a [_�a [a�/E/FY hO__�	 _�a [a V/ja�& +_�a�,a ]&E`�O_�_�a [_�a [a V/E/FY hO_�a [a�/j l_�a�,a ]&E`�O_RE`�O 7k_�j \lh _�_�a [�/  _�a [�k/E`�OY h[OY��O_�_�a [_�a [a�/E/FY hO_�a [a�/j +_�a�,a ]&E`�O_�_�a [_�a [a�/E/FY hO_�a [a�/j ^_�a�,E`�O_�e   _�a [k/_�a [_�a [a�/E/FY )_�f   _�a [l/_�a [_�a [a�/E/FY hY hO__�	 _�a [a�/ja�& +_�a�,a ]&E`�O_�_�a [_�a [a�/E/FY hO__�	 _�a [a�/ja�& ]_�aZ,a[ _�a�,a ]&E`�Y _�a�,ada ]&E`�O_�a� _�_�a [_�a [a�/E/FY hY hO__�_�a� _�a�,E`�Y 9_�a�,f  & _�a�,a�,E`�W X12a7E`�Y 	a7E`�O �_ d[a Za [l \kh a���,FO_�a [�/a�k/E`�Oa���,FO_�aKk/a�&E`�O_�_� _TE`�Y P_�aKl/a�&E`�O_�a�_�a�_�ay&a b�E`�O_�_Wa [k/ _Wa [l/E`�Y hO_�_�a [�/F[OY�XO_���,FY hO_X_�%_�%a ]&E`XO�a�#j 	 _0�a<a�& �a,a�,e  r*jFa�,_�a�&E`�O)_�k+�E`JOa�_J%a�%�%a ]&a�%_0%a ]&a�%a��a�ka�a�a�lva�a�a�a�a+ka q�Y hY hOP[OYޕOPUOPUO_Xa�_hl�O_hj�Oa, n*jFa�,_�a�&E`�O)_�k+�E`JO*j�Oa�E`�Oa�_J%a�%a��a�ka�a�a�a�mva�a�a+aga��a�,E`�UO���,FO_�a�  { Qa� GjvE`�O k_�j \kh �a�lv_�6G[OY��O*j�O*a�_ea�_�a�ea ��UW &X12a�a��a�ja�a�kva�a�aH�Y h_�a�  P &a� *j�O_ej�Oe*a�k/a�,FUW &X12a�a��a�ja�a�kva�a�aH�Y a� 	_ej�UOPW oX1����,FO_�e  [a�a��a�ja�a�kva�a�aH�O _Xa�_hl�O_hj�W X12hOa� _ej�O*j�UY h)� �++  	)� ��+�� V+ a  \ ` d h l p t x | � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �  $)-159=AEIMQVZ^bfjnrvz~��������������������������������������  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  )� ��+�� +  �)� ��+�� +  ����)� ������  ��  )� ��+�� +  !%)-158)� ��+�� +  EH)� ��+�� +  Z^bfjnq)� ��+�� +  ��)� ��+�� +  �)� ��+ �� +   �)� ��+!�� +!  ��)� ��+"�� +"  �)� ��+#�� +#  )� ��+$�� +$  ")� ��+%�� +%  /2*  �+&� +&  ?B* �+'� +'  N* �+(� +(  Z* �+)� +)  f* �+*� +*  sv* �++� ++  �* �+,� +,  �* �+-� +-  �* �+.� +.  ��*	 �+/� +/  �*
 �+0� +0  ��* �+1� +1  ��* �+2� +2  ��* �+3� +3  ���* �+4� +4  * �+5� +5  "* �+6� +6  /36* �+7� +7  CGJ* �+8� +8  W[^* �+9� +9  kor* �+:� +:  �* �+;� +;  �* �+<� +<  �* �+=� +=  �* �+>� +>  �* �+?� +?  �* �+@� +@  �* �+A� +A  �* �+B� +B  �* �+C� +C  �* �+D� +D  �* �+E� +E  *  �+F� +F  *! �+G� +G  *" �+H� +H  **# �+I� +I  6*$ �+J� +J  B*% �+K� +K  N*& �+L� +L  Z*' �+M� +M  f*( �+N� +N  r*) �+O� +O  ~** �+P� +P  �*+ �+Q� +Q  �*, �+R� +R  �*- �+S� +S  �*. �+T� +T  �*/ �+U� +U  �*0 �+V� +V  �*1 �+W� +W  �*2 �+X� +X  �*3 �+Y� +Y  �*4 �+Z� +Z  *5 �+[� +[  !*6 �+\� +\  -*7 �+]� +]  <@C*8 �+^� +^  W[^*9 �+_� +_  hk*: �+`� +`  ux*; �+a� +a  ������*< �+b� +b  ��*= �+c� +c  ��*> �+d� +d  �����*? �+e� +e  ��*@ �+f� +f  ��*A �~+g�~ +g  ����*B �}+h�} +h  *C �|+i�| +i  *D �{+j�{ +j  *E �z+k�z +k  (+*F �y+l�y +l  58*G �x+m�x +m  BE*H �w+n�w +n  OR*I �v+o�v +o  \_*J �u+p�u +p  il*K �t+q�t +q  vy*L �s+r�s +r  ��*M �r+s�r +s  ��*N �q+t�q +t  ��*O �p+u�p +u  ��*P �o+v�o +v  �������*Q �n+w�n +w  ��*R �m+x�m +x  ��*S �l+y�l +y  ��*T �k+z�k +z  �*U �j+{�j +{  *V �i+|�i p+| p "&*.26:>BFJNSW[_cgkosw{�������������������������������			
						"	&	*	/	3	7	;	?	C	G	K	O	S	W	[	`	d	h	l	p	t	x	|	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�	�*W �h+}�h 4+} 4 	�	�	�	�	�








#
'
+
0
4
8
<
@
D
H
L
P
T
X
\
`
d
i
m
q
u
y
}
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
�*X �g+~�g $+~ $ 
�
�
�
�++�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+ �+�+�  1 	 , 0+� �+�+�  I n p u t   1+� �+�+�  2 	 , 0+� �+�+�  I n p u t   2+� �+�+�  3 	 , 0+� �+�+�  I n p u t   3+� �+�+�  4 	 , 0+� �+�+�  I n p u t   4+� �+�+�  5 	 , 0+� �+�+�  I n p u t   5+� �+�+�  6 	 , 0+� �+�+�  I n p u t   6+� �+�+�  7 	 , 0+� �+�+�  I n p u t   7+� �+�+�  8 	 , 0+� �+�+�  I n p u t   8+� �+�+�  9 	 , 0+� �+�+�  I n p u t   9+� �+�+� 
 1 0 	 , 0+� �+�+�  I n p u t   1 0+� �+�+� 
 1 1 	 , 0+� �+�+�  I n p u t   1 1+� �+�+� 
 1 2 	 , 0+� �+�+�  I n p u t   1 2+� �+�+� 
 1 3 	 , 0+� �+�+�  I n p u t   1 3+� �+�+� 
 1 4 	 , 0+� �+�+�  I n p u t   1 4+� �+�+� 
 1 5 	 , 0+� �+�+�  I n p u t   1 5+� �+�+� 
 1 6 	 , 0+� �+�+�  I n p u t   1 6*Y �f+��f +�  *.26:>BE*Z �e+��e +�  SV*[ �d+��d +�  l*\ �c+��c +�  �b��b��*] �a+��a +�  �������*^ �`+��` +�  ��������������*_ �_+��_ 4+� 4 #'+/48<@DHLPTX\aeimquy}����������������������*` �^+��^ $+� $ �������� !%)-159>BFJNRVZ^bgkn*a �]+��] +�  }�����*b �\+��\ 
+� 
 ����������*c �[+��[ +�  *^*_*`)�*a*b
�A boovfals*d �Z�Y�Z  �Y  *e �X�W�X  �W  *f �+�+�  G e t   o n   w i t h   i t
�@ boovtrue*g �+�+�  T o   p a g e   2   > > >*h �+�+�  B a c k   t o   s t a r t�? *i �+�+� Z M i r r o r   M i r r o r   C a p t i o n i n g   J a n   1 8 t h   L a t e s t . c u e s�>�*j �+�+� 0 T h e   c o l u m n s   t h a t   y o u   s e e�=�
�< 
mar �; *k �+�+�  1 5 : 3 9 : 0 2*l �+�+�  2 0 1 8 0 3 2 6*m �+�+� 2 1 3   m i n u t e s   a n d   3 1   s e c o n d s*n �+�+�  1 8 - 0 3 - 2 6   1 5 3 9*o �+�+� M a c i n t o s h   H D : U s e r s : c m g : D e s k t o p : Q L a b   |   M i r r o r   M i r r o r   C a p t i o n i n g   J a n   1 8 t h   L a t e s t . c u e s   |   M a k e   a   t e x t   f i l e   f r o m   c u e s   |   1 8 - 0 3 - 2 6   1 5 3 9 . t x t*p �V+��V A+� N ��������������+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�+�, ,,,,,,,�U�T�S�R�Q�P�O�N�M�L�K�J�I+� �,,  0 , 0+� �,	,	  0 , 1+� �,
,
  0 , 2+� �,,  0 , 3+� �,,  0 , 4+� �,,  0 , 5+� �,,  0 , 6+� �,,  0 , 7+� �,,  0 , 8+� �,,  0 , 9+� �,,  0 , 1 0+� �,,  0 , 1 1+� �,,  0 , 1 2+� �,,  0 , 1 3+� �,,  0 , 1 4+� �,,  0 , 1 5+� �,,  0 , 1 6+� �,,  1 , 0+� �,,  1 , 1+� �,,  1 , 2+� �,,  1 , 3+� �,,  1 , 4+� �,,  1 , 5+� �,,  1 , 6+� �, ,   1 , 7+� �,!,!  1 , 8+� �,","  1 , 9+� �,#,#  1 , 1 0+� �,$,$  1 , 1 1+� �,%,%  1 , 1 2+� �,&,&  1 , 1 3+� �,','  1 , 1 4+� �,(,(  1 , 1 5+� �,),)  1 , 1 6+� �,*,*  2 , 0+� �,+,+  2 , 1+� �,,,,  2 , 2+� �,-,-  2 , 3+� �,.,.  2 , 4+� �,/,/  2 , 5+� �,0,0  2 , 6+� �,1,1  2 , 7+� �,2,2  2 , 8,  �,3,3  2 , 9, �,4,4  2 , 1 0, �,5,5  2 , 1 1, �,6,6  2 , 1 2, �,7,7  2 , 1 3, �,8,8  2 , 1 4, �,9,9  2 , 1 5, �,:,:  2 , 1 6�U  �T  �S  �R  �Q  �P  �O  �N  �M  �L  �K  �J  �I  *q �,;,; ( S t e r e o   t o   3 2   o u t p u t s*r �,<,< 
 O t h e r*s �,=,=  3�: *t �,>,>  1 7�9 �8 �7 *u �,?,?� u n i q u e   I D 	 t y p e 	 q   n u m b e r 	 q   n a m e 	 c u e   t a r g e t 	 f i l e   t a r g e t 	 p r e   w a i t 	 d u r a t i o n 	 p o s t   w a i t 	 c o n t i n u e   m o d e 	 b r o k e n 	 n o t e s 	 m o d e 	 i s   i n   g r o u p 	 0 , 0 	 0 , 1 	 0 , 2 	 0 , 3 	 0 , 4 	 0 , 5 	 0 , 6 	 0 , 7 	 0 , 8 	 0 , 9 	 0 , 1 0 	 0 , 1 1 	 0 , 1 2 	 0 , 1 3 	 0 , 1 4 	 0 , 1 5 	 0 , 1 6 	 1 , 0 	 1 , 1 	 1 , 2 	 1 , 3 	 1 , 4 	 1 , 5 	 1 , 6 	 1 , 7 	 1 , 8 	 1 , 9 	 1 , 1 0 	 1 , 1 1 	 1 , 1 2 	 1 , 1 3 	 1 , 1 4 	 1 , 1 5 	 1 , 1 6 	 2 , 0 	 2 , 1 	 2 , 2 	 2 , 3 	 2 , 4 	 2 , 5 	 2 , 6 	 2 , 7 	 2 , 8 	 2 , 9 	 2 , 1 0 	 2 , 1 1 	 2 , 1 2 	 2 , 1 3 	 2 , 1 4 	 2 , 1 5 	 2 , 1 6�6�*v �H,@�H A,@ P ,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,[,\,],^,_,`,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,{,|,},~,,�,��G�F�E�D�C�B�A�@�?�>�=�<�;�:�9,A �,�,�  u n i q u e   I D,B �,�,�  t y p e,C �,�,�  q   n u m b e r,D �,�,�  q   n a m e,E �,�,�  c u e   t a r g e t,F �,�,�  f i l e   t a r g e t,G �,�,�  p r e   w a i t,H �,�,�  d u r a t i o n,I �,�,�  p o s t   w a i t,J �,�,�  c o n t i n u e   m o d e,K �,�,�  b r o k e n,L �,�,� 
 n o t e s,M �,�,�  m o d e,N �,�,�  i s   i n   g r o u p,O �,�,�  0 , 0,P �,�,�  0 , 1,Q �,�,�  0 , 2,R �,�,�  0 , 3,S �,�,�  0 , 4,T �,�,�  0 , 5,U �,�,�  0 , 6,V �,�,�  0 , 7,W �,�,�  0 , 8,X �,�,�  0 , 9,Y �,�,�  0 , 1 0,Z �,�,�  0 , 1 1,[ �,�,�  0 , 1 2,\ �,�,�  0 , 1 3,] �,�,�  0 , 1 4,^ �,�,�  0 , 1 5,_ �,�,�  0 , 1 6,` �,�,�  1 , 0,a �,�,�  1 , 1,b �,�,�  1 , 2,c �,�,�  1 , 3,d �,�,�  1 , 4,e �,�,�  1 , 5,f �,�,�  1 , 6,g �,�,�  1 , 7,h �,�,�  1 , 8,i �,�,�  1 , 9,j �,�,�  1 , 1 0,k �,�,�  1 , 1 1,l �,�,�  1 , 1 2,m �,�,�  1 , 1 3,n �,�,�  1 , 1 4,o �,�,�  1 , 1 5,p �,�,�  1 , 1 6,q �,�,�  2 , 0,r �,�,�  2 , 1,s �,�,�  2 , 2,t �,�,�  2 , 3,u �,�,�  2 , 4,v �,�,�  2 , 5,w �,�,�  2 , 6,x �,�,�  2 , 7,y �,�,�  2 , 8,z �,�,�  2 , 9,{ �,�,�  2 , 1 0,| �,�,�  2 , 1 1,} �,�,�  2 , 1 2,~ �,�,�  2 , 1 3, �,�,�  2 , 1 4,� �,�,�  2 , 1 5,� �,�,�  2 , 1 6�G  �F  �E  �D  �C  �B  �A  �@  �?  �>  �=  �<  �;  �:  �9  *w ,�,�   �8�8 *0 propertiestocolumns propertiesToColumns*x �,�,�  N o   t h a n k s*y @yOJ����*z @�[J����*{ �,�,�  O K�5  �4  �3  �2  �1  �0  �/  �.  �-  �,  �+  �*  �)  �(  �'  �&  �%  �$  �#  �"  �!  �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �
  �	  �  �  �  �  �  �  �  �  ascr  ��ޭ