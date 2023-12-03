// Copyright 2023 Stefan Prodan
// SPDX-License-Identifier: Apache-2.0

package v1alpha1

import "strings"

// Annotations defines the schema for Kubernetes object metadata annotations.
#Annotations: {[string & =~"^(([A-Za-z0-9][-A-Za-z0-9_./]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)]: string}

// Labels defines the schema for Kubernetes object metadata labels.
#Labels: {[string & =~"^(([A-Za-z0-9][-A-Za-z0-9_./]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)]: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)}

#StdLabelName:      "app.kubernetes.io/name"
#StdLabelVersion:   "app.kubernetes.io/version"
#StdLabelPartOf:    "app.kubernetes.io/part-of"
#StdLabelManagedBy: "app.kubernetes.io/managed-by"
#StdLabelComponent: "app.kubernetes.io/component"
#StdLabelInstance:  "app.kubernetes.io/instance"

// Metadata defines the schema for Kubernetes object metadata.
#Metadata: {
	// Version should be in the strict semver format. Is required when creating resources.
	#Version!: string & strings.MaxRunes(63)

	// Name must be unique within a namespace. Is required when creating resources.
	// Name is primarily intended for creation idempotence and configuration definition.
	// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names
	name!: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)

	// Namespace defines the space within which each name must be unique.
	// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces
	namespace!: string & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$" & strings.MaxRunes(63)

	// Annotations is an unstructured key value map stored with a resource that may be
	// set to store and retrieve arbitrary metadata.
	// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
	annotations?: #Annotations

	// Map of string keys and values that can be used to organize and categorize (scope and select) objects.
	// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
	labels: #Labels

	// Standard Kubernetes labels: app name, version and managed-by.
	labels: {
		"\(#StdLabelName)":      name
		"\(#StdLabelVersion)":   #Version
		"\(#StdLabelManagedBy)": "Timoni"
	}
}
