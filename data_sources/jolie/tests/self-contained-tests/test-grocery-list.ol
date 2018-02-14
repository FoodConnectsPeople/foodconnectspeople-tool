include "head.iol"

main {


      undef(t);
      undef(response);

      language = "italian";
      t.convert_all = true;
      t.verbose     = false;
      t.language    = language;

      t.rec_persons[0].recipe_id = 124;
      t.rec_persons[0].persons   = 4;
      t.rec_persons[1].recipe_id = 125;
      t.rec_persons[1].persons   = 4;
      t.rec_persons[2].recipe_id = 126;
      t.rec_persons[2].persons   = 4;
      t.rec_persons[3].recipe_id = 127;
      t.rec_persons[3].persons   = 4;
      t.rec_persons[4].recipe_id = 128;
      t.rec_persons[4].persons   = 4;
      // t.rec_persons[5].recipe_id = 129;
      // t.rec_persons[5].persons   = 4;
      t.rec_persons[5].recipe_id = 130;
      t.rec_persons[5].persons   = 4;
      t.rec_persons[6].recipe_id = 131;
      t.rec_persons[6].persons   = 4;
      t.rec_persons[7].recipe_id = 132;
      t.rec_persons[7].persons   = 4;
      t.rec_persons[8].recipe_id = 133;
      t.rec_persons[8].persons   = 4;
      t.rec_persons[9].recipe_id = 134;
      t.rec_persons[9].persons   = 5;
      t.rec_persons[10].recipe_id = 135;
      t.rec_persons[10].persons   = 5;
      t.rec_persons[11].recipe_id = 136;
      t.rec_persons[11].persons   = 4;
      t.rec_persons[12].recipe_id = 137;
      t.rec_persons[12].persons   = 5;
      t.rec_persons[13].recipe_id = 138;
      t.rec_persons[13].persons   = 12;
      t.rec_persons[14].recipe_id = 139;
      t.rec_persons[14].persons   = 15;
      t.rec_persons[15].recipe_id = 140;
      t.rec_persons[15].persons   = 5;


      buildGroceryList@DbService(t)(response);

      println@Console("   ")();
      println@Console("   ")();
      println@Console("   ")();
      println@Console(" ======== CusCus GroceryList : normalized quantities =============")();
      for (l = 0, l < #response.classes, l++) {
        println@Console ("Class of ingredients: " + response.classes[l].class)();
        for (m = 0, m < #response.classes[l].ingredients, m++) {
          println@Console (" Ingredient : " + response.classes[l].ingredients[m].ingredient + " : " +
                                              response.classes[l].ingredients[m].quantity + " " +
                                              response.classes[l].ingredients[m].unit_of_measure) ()
        }
      };

      t.convert_all = false;

      buildGroceryList@DbService(t)(response);

      println@Console("   ")();
      println@Console("   ")();
      println@Console("   ")();
      println@Console(" ======== CusCus GroceryList : non-normalized quantities =============")();
      for (l = 0, l < #response.classes, l++) {
        println@Console ("Class of ingredients: " + response.classes[l].class)();
        for (m = 0, m < #response.classes[l].ingredients, m++) {
          println@Console (" Ingredient : " + response.classes[l].ingredients[m].ingredient + " : " +
                                              response.classes[l].ingredients[m].quantity + " " +
                                              response.classes[l].ingredients[m].unit_of_measure) ()
        }
      }

}
