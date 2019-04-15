# ConstraintsAsObjects
In this example, we create within our main view (self.view) three views, v1, v2, and v3, which are red, yellow, and blue rectangles respectively. For some reason, we will later want to remove the yellow view (v2) dynamically as the app runs, moving the blue view to where the yellow view was; and then, still later, we will want to insert the yellow view once again. So we have two alternating view configurations. 

![Configuration 1](ConstraintsAsObjects/views&constraints 1.png?raw=true "Configuration 1")

![Configuration 2](ConstraintsAsObjects/views&constraints 2.png?raw=true "Configuration 2")

To prepare for this, we create two sets of constraints, one describing the positions of v1, v2, and v3 when all three are present, the other describing the positions of v1 and v3 when v2 is absent. For purposes of maintaining these sets of constraints, we have already prepared two properties, constraintsWith and constraintsWithout, initialized as empty arrays of NSLayoutConstraint. We will also need a strong reference to v2, so that it doesn’t vanish when we remove it from the interface:
