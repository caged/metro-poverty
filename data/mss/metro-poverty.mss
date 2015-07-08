@land: #CBC4AA;

Map {
  background-color: #88ABA4;
}

#tracts {
  line-color: #fff;
  line-width: 0.5;
  line-opacity: 0.5;
}

#water {
  polygon-fill: #88ABA4;
}

#states {
  line-width: 1;
  line-color: #5e5b4f;
  polygon-fill: @land;
}

#land {
  polygon-fill: @land;
}

#state_labels {
  text-name: [name];
  text-face-name: 'Carnas Bold';
  text-size: 62;
  text-fill: #999;
  text-comp-op: multiply;
}
