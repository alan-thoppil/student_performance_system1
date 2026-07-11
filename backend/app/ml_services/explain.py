import shap
import lime.lime_tabular
import numpy as np

from app.ml_services.feature_builder import build_student_features
from app.ml_services.model_loader import load_model


model = load_model()


def explain_student_prediction(student_id, db):

    features = build_student_features(student_id, db)

    X = np.array(features).reshape(1,-1)

    # SHAP
    explainer = shap.KernelExplainer(model.predict, X)
    shap_values = explainer.shap_values(X)

    shap_result = {
        "studytime": float(shap_values[0][0][0]),
        "failures": float(shap_values[0][0][1]),
        "absences": float(shap_values[0][0][2]),
        "g1": float(shap_values[0][0][3]),
        "g2": float(shap_values[0][0][4]),
    }

    # LIME
    lime_explainer = lime.lime_tabular.LimeTabularExplainer(
        training_data=np.array([features]),
        feature_names=["studytime","failures","absences","g1","g2"],
        mode="classification"
    )

    exp = lime_explainer.explain_instance(
        features,
        model.predict,
        num_features=5
    )

    lime_result = dict(exp.as_list())

    return {
        "shap": shap_result,
        "lime": lime_result
    }