GDPC                @                                                                         T   res://.godot/exported/133200997/export-e70f1bd1c5efad1bd543ab36d3e40338-dragging.scn�      �      -���c�6��O@��    ,   res://.godot/global_script_class_cache.cfg                ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�
            ：Qt�E�cO���    H   res://.godot/imported/testcard.png-2f8a8f22c04a04cf1d66dbd9cef881cf.ctex�      H      ���|P�d�XoH�I�       res://.godot/uid_cache.bin   !      [       ���<֗mi�C�ؘ       res://Testcard.gd   �            T)��J$�3ۣA�>       res://card.gd           �      ^�)?%dӮ�������       res://cardmanager.gd�      +      �/��R��P��&       res://dragging.tscn.remap   �      e       p���"0�q9q�����       res://icon.svg  @      �      k����X3Y���f       res://icon.svg.import   �      �       ��`P1ן4�C��Z       res://project.binary`!            _��@��.�l4���V=       res://testcard.png.import   �      �       y��J~LI���M��?y    extends Area2D




# modified code from gemmomoh on godot forums
var canDrag = false
var cards_that_are_not_being_dragged = []
var overlaps
var prev_pos
@onready var prev_overlaps = get_overlapping_areas()

func _process(delta):
	if canDrag:
		
		$".".global_position = lerp($".".global_position, get_global_mouse_position(), 8 * delta)


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		if event.button_mask == 1:
			cards_that_are_not_being_dragged = []
			for i in get_tree().get_nodes_in_group("card"):
				if i.canDrag == false or i == self:
					cards_that_are_not_being_dragged.append(i)
			if len(cards_that_are_not_being_dragged) == len(get_tree().get_nodes_in_group("card")):
				prev_pos = position
				canDrag = true
		else:
				canDrag = false
				#var tween = get_tree().create_tween()
				#tween.tween_property(self, "position", prev_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
				
      extends Node2D
var cards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for card in get_children():
		if card.is_in_group("card"):
			cards.append(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
     RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://cardmanager.gd ��������   Script    res://card.gd ��������
   Texture2D    res://testcard.png M�;t��tG      local://RectangleShape2D_1ulb5 �         local://PackedScene_efl0r �         RectangleShape2D       
     ;C  �C         PackedScene          	         names "         Node2D    script    Card 	   position    metadata/_edit_group_    card    Area2D 	   Testcard    texture 	   Sprite2D    CollisionShape2D    shape    Card2    Card3    	   variants                 
     SC  wC                                  
    @oD ��C
    �D  �C      node_count    
         nodes     i   ��������        ����                            ����                                  	      ����                    
   
   ����                           ����                                  	      ����                    
   
   ����                           ����                                  	      ����                    
   
   ����                   conn_count              conns               node_paths              editable_instances              version             RSRCGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bxah0p76lvixm"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# hm. so i need to make the card follow the cursor on move
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
     GST2   �   E     ����               � E         RIFF  WEBPVP8L�  /� Q/@�mS�9�_��6����	O�mS�����"�G��6��Y�Y�A#I�49�p�����SD��mI�v���<�a�6�f�6��?Ηغo��Fn�FR��Pw���F���Xx�pq������B�En�6ҵ+���ɰ3ua|ʠ�n4��/��Y�ͯ�,�.��M}�1�|��1󔖭nf�T��^�v�83�r{�'�B|��o��Vl���?�N�z�U$%kh��%�X��vh�OL�ѭ�����nm �5J�j솛�:@hK.*ڇI��\D�
�,-H�fh�CL1v��v�G ф�n��}r�5z@��es\Ʋ_D4BvÈ�9jՒ7�&�qx����@(ֿ,���� ���
دx��~qPq~��m�?#e� �e]��u8o�/��ݍ��)���4���5��	�G��hkMQv1��ik��!�RO�B�霐���f&!;b;s�ʹ��d&
�v r           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cfmf2h0ga1lcn"
path="res://.godot/imported/testcard.png-2f8a8f22c04a04cf1d66dbd9cef881cf.ctex"
metadata={
"vram_texture": false
}
            [remap]

path="res://.godot/exported/133200997/export-e70f1bd1c5efad1bd543ab36d3e40338-dragging.scn"
           list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              
F���&b   res://dragging.tscnr�`��=�7   res://icon.svgM�;t��tG   res://testcard.png     ECFG      application/config/name         chop chop game thing   application/run/main_scene         res://dragging.tscn    application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg     display/window/stretch/mode         canvas_items9   rendering/textures/canvas_textures/default_texture_filter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility