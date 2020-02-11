function rzview(inp)
persistent last_pt


switch inp
  case 'on'
    last_pt = [];
    set(gcf, 'windowbuttondownfcn', ...
	 'rzview(''down'')')
    set(gcf, 'windowbuttonupfcn', ...
	 'rzview(''up'')')
    set(gcf, 'windowbuttonmotionfcn', '')
  case 'off'
    set(gcf, 'windowbuttondownfcn', '');
    set(gcf, 'windowbuttonupfcn', '');
    set(gcf, 'windowbuttonmotionfcn', '');
  case 'down'
    set(gcf, 'windowbuttonmotionfcn', ...
	 'rzview(''motion'')');
    last_pt = get_pixel_pt(gcf);
  case 'up'
    set(gcf, 'windowbuttonmotionfcn', '');
    last_pt = [];
    case 'motion'
        new_pt = get_pixel_pt(gcf);
        d = new_pt - last_pt;
        last_pt = new_pt;
        switch lower(get(gcf,'SelectionType'))
            case 'normal'
                camorbit(-d(1), -d(2), 'camera')
            case 'alt'
                q = max(-.9, min(.9, sum(d)/70));
                camzoom(1+q);
            case 'extend'
                pan_d = d*camva(gca)/500;
                campan(-pan_d(1), -pan_d(2),'camera');
            otherwise
        end
end
 
function pt = get_pixel_pt(figh)
  p_units = get(figh, 'Units');
  set(figh, 'Units', 'Pixels');
  pt = get(figh, 'CurrentPoint');
  pt = pt(1,1:2);
  set(figh, 'Units', p_units);


