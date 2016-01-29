package h2d.col;
import hxd.Math;

/**
	Another way to represent a Polygon. Segments must be connected.
	This allows efficient distance calculus.
**/
abstract Segments(Array<Segment>) from Array<Segment> to Array<Segment> {

	public var segments(get, never) : Array<Segment>;
	inline function get_segments() return this;

	public function hasPoint( p : Point, isConvex ) {
		if( isConvex ) {
			for( s in segments )
				if( s.side(p) < 0 )
					return false;
		} else {
			throw "TODO";
		}
		return true;
	}

	public function getPolygon() : Polygon {
		return [for( s in segments ) new h2d.col.Point(s.x, s.y)];
	}

	public function project( p : Point ) : Point {
		var dmin = 1e20, smin = null;
		for( s in segments ) {
			var d = s.distanceSq(p);
			if( d < dmin ) {
				dmin = d;
				smin = s;
			}
		}
		return smin.project(p);
	}

	public function distanceSq( p : Point ) {
		var dmin = 1e20;
		for( s in segments ) {
			var d = s.distanceSq(p);
			if( d < dmin ) dmin = d;
		}
		return dmin;
	}

	public inline function distance( p : Point ) {
		return Math.sqrt(distanceSq(p));
	}

}